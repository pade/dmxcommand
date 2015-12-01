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
__DESCRIPTION__ = "dmxcommand v{}\nSending DMX order to the arduino board, for remote control".format(__VERSION__)
__PROMPT__ = "Press 'q' to quit >>> "


# TO BE DEFINE
#IDPRODUCT = 0x4d03
#IDVENDOR = 0x0461
IDPRODUCT = '7523'
IDVENDOR = '1a86'

NB_CHANNEL = 4


import sys
import usb.core
import serial
import threading
import argparse
import time
import pyudev
from ola.ClientWrapper import ClientWrapper

# channel and sercom must be global to be accessible from callback function
channel = 0
sercom = None


def find_board(idVendor=IDVENDOR, idProduct=IDPRODUCT):
	'''Search the ardruino board over USB present devices
	- Parameter: 
		idVendor and idProduct: ID to search
	- Return: The mount point of the first ardruino board found, or None if no board were found 
	'''
	
	ret_value = None
	context = pyudev.Context()
	
	for device in context.list_devices(subsystem='tty'):
		if device.get('ID_VENDOR_ID') == idVendor and device.get('ID_MODEL_ID') == idProduct:
			ret_value = device.device_node
			break
	
	return ret_value

def get_data(data):
	""" Data received
	data is a 512 array of bytes. DMX channel is the index and the value is the DMX value
	"""
	
	# DMX value decoding:
	# - 0 to 127: means OFF
	# - 1 to 254: means ON
	
	i = 0
	strtosend = ""
	while i<NB_CHANNEL:
		# Get DMX order for the channel
		dmxorder = data[channel+i]
		if dmxorder > 127:
			strtosend += "{}:ON&".format(i)
		else:
			strtosend += "{}:OFF&".format(i)

		i = i+1
	# send to arduino
	try:
		global sercom
		sercom.write(strtosend)
		
		# wait to let arduino working
		time.sleep(0.4)
	except:
		print("ERROR: unable to send '{}' to arduino board".format(strtosend))
		raise
	
	print(strtosend)
	
def get_serial(evt, ser):
	'''Manage serial data comming from arduino'''
	
	while not evt.is_set():
		# get data from arduino and display it
		line = ser.readline()
		
		if len(line) > 0:
			# There's something to display
			print(__PROMPT__ + "\033[1m{}\033[0m".format(line))
		else:
			# DEBUG
			#print(__PROMPT__ + "\033[1mDEBUG\033[0m".format(line))
			pass
			
	
	#Stop serial communication with arduino
	global sercom
	sercom.close()
	
def get_keyboard(evt):
	''' Read keyboard input and exit program when 'q' is pressed'''
	
	c = ''
	while(c != 'q' and c != 'Q'):
		c = raw_input(__PROMPT__)
	# Send event to terminate all threads
	evt.set()
	
def stop_prog(evt, wrapper):
	''' Stop OLA wrapper before exiting program'''
	
	# Wait until stop event is set
	evt.wait()
	
	#event is set, stop OLA wrapper
	wrapper.Stop()
	
def main():
	
	# Parse command line argument
	parser = argparse.ArgumentParser(description=__DESCRIPTION__)
	parser.add_argument("-c", "--channel", dest="channel", help="DMX channel from 0 to 508", type=int, required=True)
	parser.add_argument("-u", "--universe", dest="universe", help="DMX universe from 1 to 4 (default is 1)", type=int, default=1)

	args = vars(parser.parse_args())
	
	print(__DESCRIPTION__)
	
	if args['channel'] > 508 or args['channel'] < 0:
		sys.exit("\nError: Channel must be  between 0 and 508\n\n")
	
	if  args['universe'] < 1 or args['universe'] > 4:
		sys.exit("\nError: Universe must be  between 0 and 4\n\n")
		
	universe = args['universe']
	
	global channel
	channel=args['channel']
	
	# Find arduino board
	usb_dev = find_board()
	
	if usb_dev is None:
		# No board found
		sys.exit("\nError: no arduino board found !\n\n")

	print("\nFind arduino board on device {}\n".format(usb_dev))
		
	# Open serial communication
	try:
		global sercom
		sercom = serial.Serial(usb_dev, 9600, timeout=0.5, writeTimeout=1)
	except:
		# Cannot open serial line with arduino
		raise
		
	
	print("Working on universe {}".format(universe))
	print("""Used DMX channel:
	- DMX channel {}: allocated to arduino channel 0
	- DMX channel {}: alloc1ated to arduino channel 1
	- DMX channel {}: allocated to arduino channel 2
	- DMX channel {}: allocated to arduino channel 3
""".format(channel, channel+1, channel+2, channel+3))	
		
	universe = 1
	wrapper = ClientWrapper()
	client = wrapper.Client()
	client.RegisterUniverse(universe, client.REGISTER, get_data)
	
	# Create an  event to stop the program
	stopEvent = threading.Event()

	# Create threads for arduino communication, keyboard input and OLA wrapper management
	usbcom_th = threading.Thread(None, get_serial, args = (stopEvent, sercom))
	usbcom_th.start()
	keyboard_th = threading.Thread(None, get_keyboard, args = (stopEvent,))
	keyboard_th.start()
	stop_th = threading.Thread(None, stop_prog, args = (stopEvent, wrapper))
	stop_th.start()

	
	wrapper.Run()
	
	# Wait all thread to stop
	usbcom_th.join()
	keyboard_th.join()
	stop_th.join()
	
	print ("\nTerminated on user request")

if __name__ == '__main__':
	main()

