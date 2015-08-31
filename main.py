#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  main.py
#  
#  Copyright 2015 dassier <dassier@debtst64>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

IDPRODUCT = 0x0
IDVENDOR = 0x0

import sys
import usb.core
import pprint
import threading
import argparse
from ola.ClientWrapper import ClientWrapper


def find_board(bus=None, idVendor=IDVENDOR, idProduct=IDPRODUCT):
	'''Search the ardruino board over USB present devices
	- Parameter: 
		bus: specify the USB bus where to search the board. If not specify, search on all buses
		idVendor and idProduct: ID to search, If both are 0x0, then seaerch all product and all vendor (debug purpose)
	- Return: a list of mount point of all ardruino boards found, or an empty list if no board were found 
	'''
	if idVendor==0x0 and idProduct==0x0:
		dev = usb.core.find(find_all=True)
	else:
		dev = usb.core.find(find_all=True, idVendor=idVendor, idProduct=idProduct)
		
	if dev is None:
		return []
	
	lst = []
	for device in dev:
		lst.append("/dev/bus/usb/%s/%s" % (device.bus, device.address))
	return lst

def NewData(data):
	""" Data received
	data is a 512 array of bytes. DMX channel is the index and the value is the DMX value
	"""
	
	print data

def main():
	
	# Parse command line argument
	parser = argparse.ArgumentParser(description="Sending DMX order to the arduino board, for remote control")
	parser.add_argument("-c", "--channel", dest="channel", help="DMX channel from 0 to 508", type=int, required=True)
	parser.add_argument("-u", "--universe", dest="universe", help="DMX universe from 1 to 4 (default is 1)", type=int, default=1)

	args = vars(parser.parse_args())
	
	if args['channel'] > 508 or args['channel'] < 0:
		sys.exit("\nError: Channel must be  between 0 and 508\n\n")
	
	if  args['universe'] < 1 or args['universe'] > 4:
		sys.exit("\nError: Universe must be  between 0 and 4\n\n")
		
	universe = args['universe']
	channel=args['channel']
	
	print("Working on universe {}".format(universe))
	print("""Used DMX channel:
	- DMX channel {}: allocated to arduino channel 0
	- DMX channel {}: allocated to arduino channel 1
	- DMX channel {}: allocated to arduino channel 2
	- DMX channel {}: allocated to arduino channel 3
""".format(channel, channel+1, channel+2, channel+3, channel+4))	
	
	#usb_dev = find_board()
	#pprint.pprint(usb_dev)
	
	universe = 1
	wrapper = ClientWrapper()
	client = wrapper.Client()
	client.RegisterUniverse(universe, client.REGISTER, NewData)
	wrapper.Run()
	
if __name__ == '__main__':
	main()

