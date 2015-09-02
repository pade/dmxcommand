#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  dmxcommand.py
#  
#  Copyright 2015 Patrick Dssier <pdassier@free.fr>
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

__VERSION__ = "0.1"
DESCRIPTION = "dmxcommand v{}\nSending DMX order to the arduino board, for remote control".format(__VERSION__)

# TO BE DEFINE
#IDPRODUCT = 0x4d03
#IDVENDOR = 0x0461
IDPRODUCT = 0x003
IDVENDOR = 0x0e0f

PROMPT = "Press 'q' to quit"

import sys
import usb.core
import serial
import pprint
import threading
import argparse
from ola.ClientWrapper import ClientWrapper

# Channel must be global to be accessible from callback function
channel = 0

wrapper = ClientWrapper()


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
		lst.append("/dev/bus/usb/%03d/%03d" % (device.bus, device.address))
	return lst

def NewData(data):
	""" Data received
	data is a 512 array of bytes. DMX channel is the index and the value is the DMX value
	"""
	
	# DMX value decoding:
	# - 0 to 127: means OFF
	# - 1 to 254: means ON
	
	i = 0
	while i<4:
		# Get DMX order for the channel
		dmxorder = data[channel+i]
		if dmxorder > 127:
			strtosend = "{}:ON".format(i)
		else:
			strtosend = "{}:OFF".format(i)

		#TODO: send to arduino
		print(strtosend)
		i = i+1
	
def get_serial(evt, ser):
	'''Manage serial data comming from arduino'''
	
	while not evt.is_set():
		# get data from arduino and display it
		line = ser.readline()
		
		if len(line) > 0:
			# There's something to display
			print("Press 'q' to quit>>> \033[1m{}\033[0m".format(line))
		else:
			# DEBUG
			print("Press 'q' to quit>>> \033[1mDEBUG\033[0m".format(line))

			
	
	#Stop serial communication with arduino
	ser.close()
	
def get_keyboard(evt):
	''' Read keyboard input and exit program when 'q' is pressed'''
	
	c = ''
	while(c != 'q' and c != 'Q'):
		c = raw_input(PROMPT)
	# Send event to terminate all threads
	evt.set()
	
def stop_prog(evt):
	''' Stop OLA wrapper before exiting program'''
	
	# Wait until stop event is set
	evt.wait()
	
	#event is set, stop OLA wrapper
	wrapper.Stop()
	
def main():
	
	# Parse command line argument
	parser = argparse.ArgumentParser(description=DESCRIPTION)
	parser.add_argument("-c", "--channel", dest="channel", help="DMX channel from 0 to 508", type=int, required=True)
	parser.add_argument("-u", "--universe", dest="universe", help="DMX universe from 1 to 4 (default is 1)", type=int, default=1)

	args = vars(parser.parse_args())
	
	print(DESCRIPTION)
	
	if args['channel'] > 508 or args['channel'] < 0:
		sys.exit("\nError: Channel must be  between 0 and 508\n\n")
	
	if  args['universe'] < 1 or args['universe'] > 4:
		sys.exit("\nError: Universe must be  between 0 and 4\n\n")
		
	universe = args['universe']
	
	global channel
	channel=args['channel']
	
	# Find arduino board
	usb_dev = find_board()
	
	if len(usb_dev) == 0:
		# No board found
		sys.exit("\nError: no arduino board found !\n\n")
	
	if len(usb_dev) > 1:
		# Several board found, not managed yet
		sys.exit("\nError: several arduino board found, please let only one\n\n")

	print("\nFind arduino board on device {}\n".format(usb_dev[0]))
		
	# Open serial communication
	try:
		#ser = serial.Serial(usb_dev[0], 9600, timeout=0.5)
		ser = serial.Serial("/dev/ttyS0", 9600, timeout=0.5)
	except:
		# Cannot open serial line with arduino
		raise
		
	
	print("Working on universe {}".format(universe))
	print("""Used DMX channel:
	- DMX channel {}: allocated to arduino channel 0
	- DMX channel {}: alloc1ated to arduino channel 1
	- DMX channel {}: allocated to arduino channel 2
	- DMX channel {}: allocated to arduino channel 3
""".format(channel, channel+1, channel+2, channel+3, channel+4))	
		
	universe = 1
	client = wrapper.Client()
	client.RegisterUniverse(universe, client.REGISTER, NewData)
	
	# Create an  event to stop the program
	stopEvent = threading.Event()

	# Create threads for arduino communication, keyboard input and OLA wrapper management
	usbcom_th = threading.Thread(None, get_serial, args = (stopEvent, ser))
	usbcom_th.start()
	keyboard_th = threading.Thread(None, get_keyboard, args = (stopEvent,))
	keyboard_th.start()
	stop_th = threading.Thread(None, stop_prog, args = (stopEvent,))
	stop_th.start()

	
	wrapper.Run()
	
	# Wait all thread to stop
	usbcom_th.join()
	keyboard_th.join()
	stop_th.join()
	
	print ("\nTerminated on user request")

if __name__ == '__main__':
	main()

