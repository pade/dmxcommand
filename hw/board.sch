EESchema Schematic File Version 2
LIBS:board-rescue
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
LIBS:board-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "21 sep 2015"
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
L R-RESCUE-board R1
U 1 1 55FD3C19
P 2350 3750
F 0 "R1" V 2430 3750 40  0000 C CNN
F 1 "1K" V 2357 3751 40  0000 C CNN
F 2 "~" V 2280 3750 30  0000 C CNN
F 3 "~" H 2350 3750 30  0000 C CNN
	1    2350 3750
	1    0    0    -1  
$EndComp
$Comp
L C-RESCUE-board C1
U 1 1 55FD3C28
P 2350 4450
F 0 "C1" H 2350 4550 40  0000 L CNN
F 1 "100nF" H 2356 4365 40  0000 L CNN
F 2 "~" H 2388 4300 30  0000 C CNN
F 3 "~" H 2350 4450 60  0000 C CNN
	1    2350 4450
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 55FD3C5B
P 2750 4550
F 0 "SW1" H 2900 4660 50  0000 C CNN
F 1 "SW_PUSH" H 2750 4470 50  0000 C CNN
F 2 "~" H 2750 4550 60  0000 C CNN
F 3 "~" H 2750 4550 60  0000 C CNN
	1    2750 4550
	0    -1   -1   0   
$EndComp
$Comp
L GND-RESCUE-board #PWR01
U 1 1 55FD3C70
P 2350 5200
F 0 "#PWR01" H 2350 5200 30  0001 C CNN
F 1 "GND" H 2350 5130 30  0001 C CNN
F 2 "" H 2350 5200 60  0000 C CNN
F 3 "" H 2350 5200 60  0000 C CNN
	1    2350 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 4250 2750 4250
Wire Wire Line
	2350 4000 2350 4250
Wire Wire Line
	2350 3500 2350 3250
Wire Wire Line
	2350 4650 2350 5200
Wire Wire Line
	2750 4850 2750 4950
Wire Wire Line
	2750 4950 2350 4950
Connection ~ 2350 4950
Connection ~ 2350 4100
$Comp
L R-RESCUE-board R4
U 1 1 55FFADFE
P 3150 5700
F 0 "R4" V 3230 5700 40  0000 C CNN
F 1 "1K" V 3157 5701 40  0000 C CNN
F 2 "~" V 3080 5700 30  0000 C CNN
F 3 "~" H 3150 5700 30  0000 C CNN
	1    3150 5700
	1    0    0    -1  
$EndComp
$Comp
L C-RESCUE-board C4
U 1 1 55FFAE0D
P 3150 6350
F 0 "C4" H 3150 6450 40  0000 L CNN
F 1 "100nF" H 3156 6265 40  0000 L CNN
F 2 "~" H 3188 6200 30  0000 C CNN
F 3 "~" H 3150 6350 60  0000 C CNN
	1    3150 6350
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW4
U 1 1 55FFAE33
P 3700 6300
F 0 "SW4" H 3850 6410 50  0000 C CNN
F 1 "SW_PUSH" H 3700 6220 50  0000 C CNN
F 2 "~" H 3700 6300 60  0000 C CNN
F 3 "~" H 3700 6300 60  0000 C CNN
	1    3700 6300
	0    -1   -1   0   
$EndComp
$Comp
L GND-RESCUE-board #PWR02
U 1 1 55FFAE8C
P 3150 6800
F 0 "#PWR02" H 3150 6800 30  0001 C CNN
F 1 "GND" H 3150 6730 30  0001 C CNN
F 2 "" H 3150 6800 60  0000 C CNN
F 3 "" H 3150 6800 60  0000 C CNN
	1    3150 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 5175 3150 5450
Wire Wire Line
	3150 5950 3150 6150
Wire Wire Line
	3150 6550 3150 6800
Wire Wire Line
	3150 6000 3700 6000
Connection ~ 3150 6000
Wire Wire Line
	3700 6600 3700 6700
Wire Wire Line
	3700 6700 3150 6700
Connection ~ 3150 6700
$Comp
L GND-RESCUE-board #PWR03
U 1 1 55FFAFE2
P 3170 2675
F 0 "#PWR03" H 3170 2675 30  0001 C CNN
F 1 "GND" H 3170 2605 30  0001 C CNN
F 2 "" H 3170 2675 60  0000 C CNN
F 3 "" H 3170 2675 60  0000 C CNN
	1    3170 2675
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-board D1
U 1 1 55FFB090
P 3525 2675
F 0 "D1" H 3525 2775 50  0000 C CNN
F 1 "LED" H 3525 2575 50  0000 C CNN
F 2 "~" H 3525 2675 60  0000 C CNN
F 3 "~" H 3525 2675 60  0000 C CNN
	1    3525 2675
	-1   0    0    1   
$EndComp
$Comp
L R-RESCUE-board R5
U 1 1 55FFB09F
P 4200 2675
F 0 "R5" V 4280 2675 40  0000 C CNN
F 1 "170" V 4207 2676 40  0000 C CNN
F 2 "~" V 4130 2675 30  0000 C CNN
F 3 "~" H 4200 2675 30  0000 C CNN
	1    4200 2675
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 2675 3725 2675
Wire Wire Line
	3150 2675 3325 2675
Text GLabel 3525 5775 1    60   Input ~ 0
9
Wire Wire Line
	4800 4225 4650 4225
Wire Wire Line
	3525 5775 3525 6000
Connection ~ 3525 6000
Text GLabel 4650 4225 0    60   Input ~ 0
9
Text GLabel 4500 4100 0    60   Input ~ 0
8
Wire Wire Line
	4500 4100 4800 4100
Text GLabel 2625 4125 1    60   Input ~ 0
8
Wire Wire Line
	2625 4125 2625 4250
Connection ~ 2625 4250
$Comp
L R-RESCUE-board R3
U 1 1 56000B5A
P 1600 5675
F 0 "R3" V 1680 5675 40  0000 C CNN
F 1 "1K" V 1607 5676 40  0000 C CNN
F 2 "~" V 1530 5675 30  0000 C CNN
F 3 "~" H 1600 5675 30  0000 C CNN
	1    1600 5675
	1    0    0    -1  
$EndComp
$Comp
L C-RESCUE-board C3
U 1 1 56000B60
P 1600 6325
F 0 "C3" H 1600 6425 40  0000 L CNN
F 1 "100nF" H 1606 6240 40  0000 L CNN
F 2 "~" H 1638 6175 30  0000 C CNN
F 3 "~" H 1600 6325 60  0000 C CNN
	1    1600 6325
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW3
U 1 1 56000B66
P 2150 6275
F 0 "SW3" H 2300 6385 50  0000 C CNN
F 1 "SW_PUSH" H 2150 6195 50  0000 C CNN
F 2 "~" H 2150 6275 60  0000 C CNN
F 3 "~" H 2150 6275 60  0000 C CNN
	1    2150 6275
	0    -1   -1   0   
$EndComp
$Comp
L GND-RESCUE-board #PWR04
U 1 1 56000B72
P 1600 6775
F 0 "#PWR04" H 1600 6775 30  0001 C CNN
F 1 "GND" H 1600 6705 30  0001 C CNN
F 2 "" H 1600 6775 60  0000 C CNN
F 3 "" H 1600 6775 60  0000 C CNN
	1    1600 6775
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 5325 1600 5425
Wire Wire Line
	1600 5925 1600 6125
Wire Wire Line
	1600 6525 1600 6775
Wire Wire Line
	1600 5975 2150 5975
Connection ~ 1600 5975
Wire Wire Line
	2150 6575 2150 6675
Wire Wire Line
	2150 6675 1600 6675
Connection ~ 1600 6675
Text GLabel 1975 5750 1    60   Input ~ 0
7
Wire Wire Line
	1975 5750 1975 5975
Connection ~ 1975 5975
Text GLabel 4300 3975 0    60   Input ~ 0
7
Wire Wire Line
	4300 3975 4800 3975
$Comp
L R-RESCUE-board R2
U 1 1 56000BD3
P 1000 3975
F 0 "R2" V 1080 3975 40  0000 C CNN
F 1 "1K" V 1007 3976 40  0000 C CNN
F 2 "~" V 930 3975 30  0000 C CNN
F 3 "~" H 1000 3975 30  0000 C CNN
	1    1000 3975
	1    0    0    -1  
$EndComp
$Comp
L C-RESCUE-board C2
U 1 1 56000BD9
P 1000 4625
F 0 "C2" H 1000 4725 40  0000 L CNN
F 1 "100nF" H 1006 4540 40  0000 L CNN
F 2 "~" H 1038 4475 30  0000 C CNN
F 3 "~" H 1000 4625 60  0000 C CNN
	1    1000 4625
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW2
U 1 1 56000BDF
P 1550 4575
F 0 "SW2" H 1700 4685 50  0000 C CNN
F 1 "SW_PUSH" H 1550 4495 50  0000 C CNN
F 2 "~" H 1550 4575 60  0000 C CNN
F 3 "~" H 1550 4575 60  0000 C CNN
	1    1550 4575
	0    -1   -1   0   
$EndComp
$Comp
L GND-RESCUE-board #PWR05
U 1 1 56000BEB
P 1000 5075
F 0 "#PWR05" H 1000 5075 30  0001 C CNN
F 1 "GND" H 1000 5005 30  0001 C CNN
F 2 "" H 1000 5075 60  0000 C CNN
F 3 "" H 1000 5075 60  0000 C CNN
	1    1000 5075
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 3625 1000 3725
Wire Wire Line
	1000 4225 1000 4425
Wire Wire Line
	1000 4825 1000 5075
Wire Wire Line
	1000 4275 1550 4275
Connection ~ 1000 4275
Wire Wire Line
	1550 4875 1550 4975
Wire Wire Line
	1550 4975 1000 4975
Connection ~ 1000 4975
Text GLabel 1375 4050 1    60   Input ~ 0
6
Wire Wire Line
	1375 4050 1375 4275
Connection ~ 1375 4275
Text GLabel 4425 3850 0    60   Input ~ 0
6
Wire Wire Line
	4425 3850 4800 3850
$Comp
L GND-RESCUE-board #PWR06
U 1 1 56000C4A
P 3170 2950
F 0 "#PWR06" H 3170 2950 30  0001 C CNN
F 1 "GND" H 3170 2880 30  0001 C CNN
F 2 "" H 3170 2950 60  0000 C CNN
F 3 "" H 3170 2950 60  0000 C CNN
	1    3170 2950
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-board D2
U 1 1 56000C50
P 3525 2950
F 0 "D2" H 3525 3050 50  0000 C CNN
F 1 "LED" H 3525 2850 50  0000 C CNN
F 2 "~" H 3525 2950 60  0000 C CNN
F 3 "~" H 3525 2950 60  0000 C CNN
	1    3525 2950
	-1   0    0    1   
$EndComp
$Comp
L R-RESCUE-board R6
U 1 1 56000C56
P 4200 2950
F 0 "R6" V 4280 2950 40  0000 C CNN
F 1 "170" V 4207 2951 40  0000 C CNN
F 2 "~" V 4130 2950 30  0000 C CNN
F 3 "~" H 4200 2950 30  0000 C CNN
	1    4200 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 2950 3725 2950
Wire Wire Line
	3150 2950 3325 2950
$Comp
L GND-RESCUE-board #PWR07
U 1 1 56000C5E
P 3170 3200
F 0 "#PWR07" H 3170 3200 30  0001 C CNN
F 1 "GND" H 3170 3130 30  0001 C CNN
F 2 "" H 3170 3200 60  0000 C CNN
F 3 "" H 3170 3200 60  0000 C CNN
	1    3170 3200
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-board D3
U 1 1 56000C64
P 3525 3200
F 0 "D3" H 3525 3300 50  0000 C CNN
F 1 "LED" H 3525 3100 50  0000 C CNN
F 2 "~" H 3525 3200 60  0000 C CNN
F 3 "~" H 3525 3200 60  0000 C CNN
	1    3525 3200
	-1   0    0    1   
$EndComp
$Comp
L R-RESCUE-board R7
U 1 1 56000C6A
P 4200 3200
F 0 "R7" V 4280 3200 40  0000 C CNN
F 1 "170" V 4207 3201 40  0000 C CNN
F 2 "~" V 4130 3200 30  0000 C CNN
F 3 "~" H 4200 3200 30  0000 C CNN
	1    4200 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 3200 3725 3200
Wire Wire Line
	3150 3200 3325 3200
$Comp
L GND-RESCUE-board #PWR08
U 1 1 56000C72
P 3170 3475
F 0 "#PWR08" H 3170 3475 30  0001 C CNN
F 1 "GND" H 3170 3405 30  0001 C CNN
F 2 "" H 3170 3475 60  0000 C CNN
F 3 "" H 3170 3475 60  0000 C CNN
	1    3170 3475
	0    1    1    0   
$EndComp
$Comp
L LED-RESCUE-board D4
U 1 1 56000C78
P 3525 3475
F 0 "D4" H 3525 3575 50  0000 C CNN
F 1 "LED" H 3525 3375 50  0000 C CNN
F 2 "~" H 3525 3475 60  0000 C CNN
F 3 "~" H 3525 3475 60  0000 C CNN
	1    3525 3475
	-1   0    0    1   
$EndComp
$Comp
L R-RESCUE-board R8
U 1 1 56000C7E
P 4200 3475
F 0 "R8" V 4280 3475 40  0000 C CNN
F 1 "170" V 4207 3476 40  0000 C CNN
F 2 "~" V 4130 3475 30  0000 C CNN
F 3 "~" H 4200 3475 30  0000 C CNN
	1    4200 3475
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 3475 3725 3475
Wire Wire Line
	3150 3475 3325 3475
Wire Wire Line
	4450 2675 4725 2675
Wire Wire Line
	4725 2675 4725 3350
Wire Wire Line
	4725 3350 4800 3350
Wire Wire Line
	4450 2950 4650 2950
Wire Wire Line
	4650 2950 4650 3475
Wire Wire Line
	4650 3475 4800 3475
Wire Wire Line
	4450 3200 4600 3200
Wire Wire Line
	4600 3200 4600 3600
Wire Wire Line
	4600 3600 4800 3600
Wire Wire Line
	4450 3475 4500 3475
Wire Wire Line
	4500 3725 4800 3725
Wire Wire Line
	4500 3475 4500 3725
$Comp
L CONN_2 P1
U 1 1 56000DB4
P 7875 2075
F 0 "P1" V 7825 2075 40  0000 C CNN
F 1 "CONN_2" V 7925 2075 40  0000 C CNN
F 2 "" H 7875 2075 60  0000 C CNN
F 3 "" H 7875 2075 60  0000 C CNN
	1    7875 2075
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR09
U 1 1 56000DC3
P 6375 2375
F 0 "#PWR09" H 6375 2475 30  0001 C CNN
F 1 "VCC" H 6375 2475 30  0000 C CNN
F 2 "" H 6375 2375 60  0000 C CNN
F 3 "" H 6375 2375 60  0000 C CNN
	1    6375 2375
	1    0    0    -1  
$EndComp
$Comp
L GND-RESCUE-board #PWR010
U 1 1 56000DD2
P 7975 2800
F 0 "#PWR010" H 7975 2800 30  0001 C CNN
F 1 "GND" H 7975 2730 30  0001 C CNN
F 2 "" H 7975 2800 60  0000 C CNN
F 3 "" H 7975 2800 60  0000 C CNN
	1    7975 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6275 2525 6275 2850
Wire Wire Line
	6275 2850 6100 2850
Wire Wire Line
	6375 2375 6375 2525
Connection ~ 6375 2525
Wire Wire Line
	6450 2975 6100 2975
Text Notes 7800 1925 0    60   ~ 0
12V
$Comp
L CONN_3 K1
U 1 1 56000F8F
P 5375 5050
F 0 "K1" V 5325 5050 50  0000 C CNN
F 1 "CONN_3" V 5425 5050 40  0000 C CNN
F 2 "" H 5375 5050 60  0000 C CNN
F 3 "" H 5375 5050 60  0000 C CNN
	1    5375 5050
	0    1    -1   0   
$EndComp
Wire Wire Line
	4800 4600 4700 4600
Wire Wire Line
	4700 4600 4700 5400
Wire Wire Line
	4700 5400 5275 5400
$Comp
L GND-RESCUE-board #PWR011
U 1 1 56000FFE
P 5375 5675
F 0 "#PWR011" H 5375 5675 30  0001 C CNN
F 1 "GND" H 5375 5605 30  0001 C CNN
F 2 "" H 5375 5675 60  0000 C CNN
F 3 "" H 5375 5675 60  0000 C CNN
	1    5375 5675
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR012
U 1 1 5600100D
P 5475 5475
F 0 "#PWR012" H 5475 5575 30  0001 C CNN
F 1 "VCC" H 5475 5575 30  0000 C CNN
F 2 "" H 5475 5475 60  0000 C CNN
F 3 "" H 5475 5475 60  0000 C CNN
	1    5475 5475
	-1   0    0    1   
$EndComp
Wire Wire Line
	5475 5400 5475 5475
Text Notes 5575 5075 0    60   ~ 0
RF 433MHz transmitter
Wire Wire Line
	6275 2525 6550 2525
Wire Wire Line
	7975 2425 7975 2800
Wire Wire Line
	7975 2750 6450 2750
Wire Wire Line
	6450 2750 6450 2975
Connection ~ 7975 2750
$Comp
L SPST SW5
U 1 1 5600129C
P 7050 2525
F 0 "SW5" H 7050 2625 70  0000 C CNN
F 1 "SPST" H 7050 2425 70  0000 C CNN
F 2 "~" H 7050 2525 60  0000 C CNN
F 3 "~" H 7050 2525 60  0000 C CNN
	1    7050 2525
	1    0    0    -1  
$EndComp
Wire Wire Line
	7775 2425 7775 2525
Wire Wire Line
	7775 2525 7550 2525
Wire Wire Line
	5375 5400 5375 5675
Text GLabel 6500 3225 2    60   Input ~ 0
5V
Wire Wire Line
	6100 3225 6500 3225
Text GLabel 3150 5175 1    60   Input ~ 0
5V
Text GLabel 1600 5325 1    60   Input ~ 0
5V
Text GLabel 2350 3250 1    60   Input ~ 0
5V
Text GLabel 1000 3625 1    60   Input ~ 0
5V
$Comp
L VCC #PWR?
U 1 1 5600145A
P 4675 3300
F 0 "#PWR?" H 4675 3400 30  0001 C CNN
F 1 "VCC" H 4675 3400 30  0000 C CNN
F 2 "" H 4675 3300 60  0000 C CNN
F 3 "" H 4675 3300 60  0000 C CNN
	1    4675 3300
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 56001469
P 7500 3325
F 0 "#PWR?" H 7500 3425 30  0001 C CNN
F 1 "VCC" H 7500 3425 30  0000 C CNN
F 2 "" H 7500 3325 60  0000 C CNN
F 3 "" H 7500 3325 60  0000 C CNN
	1    7500 3325
	1    0    0    -1  
$EndComp
$Comp
L R-RESCUE-board R?
U 1 1 56001478
P 7500 3700
F 0 "R?" V 7580 3700 40  0000 C CNN
F 1 "R" V 7507 3701 40  0000 C CNN
F 2 "~" V 7430 3700 30  0000 C CNN
F 3 "~" H 7500 3700 30  0000 C CNN
	1    7500 3700
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-board D?
U 1 1 56001487
P 7500 4350
F 0 "D?" H 7500 4450 50  0000 C CNN
F 1 "LED" H 7500 4250 50  0000 C CNN
F 2 "~" H 7500 4350 60  0000 C CNN
F 3 "~" H 7500 4350 60  0000 C CNN
	1    7500 4350
	0    1    1    0   
$EndComp
$Comp
L GND-RESCUE-board #PWR?
U 1 1 56001496
P 7500 4725
F 0 "#PWR?" H 7500 4725 30  0001 C CNN
F 1 "GND" H 7500 4655 30  0001 C CNN
F 2 "" H 7500 4725 60  0000 C CNN
F 3 "" H 7500 4725 60  0000 C CNN
	1    7500 4725
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 3325 7500 3450
Wire Wire Line
	7500 3950 7500 4150
Wire Wire Line
	7500 4550 7500 4725
$EndSCHEMATC
