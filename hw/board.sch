EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:shield_arduino
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "19 sep 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ARDUINO_NANO SH1
U 1 1 55FD3C0A
P 5450 3700
F 0 "SH1" H 5425 2625 60  0000 C CNN
F 1 "ARDUINO_NANO" H 5425 4750 60  0000 C CNN
F 2 "" H 4525 3100 60  0000 C CNN
F 3 "" H 4525 3100 60  0000 C CNN
	1    5450 3700
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 55FD3C19
P 3900 3750
F 0 "R1" V 3980 3750 40  0000 C CNN
F 1 "1K" V 3907 3751 40  0000 C CNN
F 2 "~" V 3830 3750 30  0000 C CNN
F 3 "~" H 3900 3750 30  0000 C CNN
	1    3900 3750
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 55FD3C28
P 3900 4450
F 0 "C1" H 3900 4550 40  0000 L CNN
F 1 "100nF" H 3906 4365 40  0000 L CNN
F 2 "~" H 3938 4300 30  0000 C CNN
F 3 "~" H 3900 4450 60  0000 C CNN
	1    3900 4450
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 55FD3C5B
P 4300 4550
F 0 "SW1" H 4450 4660 50  0000 C CNN
F 1 "SW_PUSH" H 4300 4470 50  0000 C CNN
F 2 "~" H 4300 4550 60  0000 C CNN
F 3 "~" H 4300 4550 60  0000 C CNN
	1    4300 4550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR2
U 1 1 55FD3C70
P 3900 5200
F 0 "#PWR2" H 3900 5200 30  0001 C CNN
F 1 "GND" H 3900 5130 30  0001 C CNN
F 2 "" H 3900 5200 60  0000 C CNN
F 3 "" H 3900 5200 60  0000 C CNN
	1    3900 5200
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR1
U 1 1 55FD3C7F
P 3900 3250
F 0 "#PWR1" H 3900 3350 30  0001 C CNN
F 1 "VCC" H 3900 3350 30  0000 C CNN
F 2 "" H 3900 3250 60  0000 C CNN
F 3 "" H 3900 3250 60  0000 C CNN
	1    3900 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 4250 3900 4250
Wire Wire Line
	3900 4250 3900 4000
Wire Wire Line
	3900 3500 3900 3250
Wire Wire Line
	3900 4650 3900 5200
Wire Wire Line
	4300 4850 4300 4950
Wire Wire Line
	4300 4950 3900 4950
Connection ~ 3900 4950
Wire Wire Line
	4800 4100 3900 4100
Connection ~ 3900 4100
$EndSCHEMATC
