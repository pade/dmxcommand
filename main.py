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

import usb.core
import pprint

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

def main():
	
	usb_dev = find_board()
	pprint.pprint(usb_dev)
	
if __name__ == '__main__':
	main()

