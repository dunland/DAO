EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
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
LIBS:custom
LIBS:otheringmachines03-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATMEGA328P-AU U2
U 1 1 5A55CCEA
P 5150 3500
F 0 "U2" H 4400 4750 50  0000 L BNN
F 1 "ATMEGA328P-AU" H 5550 2100 50  0000 L BNN
F 2 "custom:TQFP-32_7x7mm_Pitch0.8mm" H 5150 3500 50  0001 C CIN
F 3 "" H 5150 3500 50  0001 C CNN
	1    5150 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5A55D245
P 1200 1600
F 0 "#PWR01" H 1200 1350 50  0001 C CNN
F 1 "GND" V 1200 1400 50  0000 C CNN
F 2 "" H 1200 1600 50  0001 C CNN
F 3 "" H 1200 1600 50  0001 C CNN
	1    1200 1600
	0    1    1    0   
$EndComp
Text Label 1200 1600 0    60   ~ 0
GND
Text Label 4250 4500 2    60   ~ 0
GND
Text Label 4250 4600 2    60   ~ 0
GND
Text Label 4250 4700 2    60   ~ 0
GND
Text Label 4250 2400 2    60   ~ 0
5V
Text Label 4250 2500 2    60   ~ 0
5V
Text Label 4250 2700 2    60   ~ 0
5V
$Comp
L AVR-ISP-6 ISP1
U 1 1 5A55DD7E
P 6550 1400
F 0 "ISP1" H 6445 1640 50  0000 C CNN
F 1 "AVR-ISP-6" H 6285 1170 50  0000 L BNN
F 2 "custom:Pin_Header_Straight_2x03_Pitch2.54mm_SMD" V 6030 1440 50  0001 C CNN
F 3 "" H 6525 1400 50  0001 C CNN
	1    6550 1400
	1    0    0    -1  
$EndComp
$Comp
L LM386 U3
U 1 1 5A55E171
P 9650 4050
F 0 "U3" V 9300 4200 50  0000 L CNN
F 1 "LM386" V 9300 3900 50  0000 L CNN
F 2 "Housings_SOIC:SOIC-8_3.9x4.9mm_Pitch1.27mm" H 9750 4150 50  0001 C CNN
F 3 "" H 9850 4250 50  0001 C CNN
	1    9650 4050
	0    -1   -1   0   
$EndComp
$Comp
L C C7
U 1 1 5A55E93A
P 9550 4700
F 0 "C7" H 9650 4700 50  0000 L CNN
F 1 "0.1uF" H 9250 4700 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 9588 4550 50  0001 C CNN
F 3 "" H 9550 4700 50  0001 C CNN
	1    9550 4700
	1    0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 5A55EA93
P 9550 5200
F 0 "R9" V 9630 5200 50  0000 C CNN
F 1 "30K" V 9550 5200 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 9480 5200 50  0001 C CNN
F 3 "" H 9550 5200 50  0001 C CNN
	1    9550 5200
	1    0    0    -1  
$EndComp
$Comp
L Microphone MK1
U 1 1 5A55EE71
P 9050 4900
F 0 "MK1" V 9200 4950 50  0000 R CNN
F 1 "Microphone" V 8900 5100 50  0000 R CNN
F 2 "custom:Microphone_Electret_WM52" V 9050 5000 50  0001 C CNN
F 3 "" V 9050 5000 50  0001 C CNN
	1    9050 4900
	0    -1   -1   0   
$EndComp
Text Label 8850 4900 2    60   ~ 0
GND
Text Label 10050 4350 0    60   ~ 0
GND
$Comp
L D D3
U 1 1 5A55F283
P 9650 3500
F 0 "D3" V 9650 3600 50  0000 C CNN
F 1 "D" V 9650 3400 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" H 9650 3500 50  0001 C CNN
F 3 "" H 9650 3500 50  0001 C CNN
	1    9650 3500
	0    1    1    0   
$EndComp
$Comp
L R R10
U 1 1 5A55FD56
P 10150 3200
F 0 "R10" V 10230 3200 50  0000 C CNN
F 1 "2.2K" V 10150 3200 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 10080 3200 50  0001 C CNN
F 3 "" H 10150 3200 50  0001 C CNN
	1    10150 3200
	1    0    0    -1  
$EndComp
Text Label 10150 3050 0    60   ~ 0
GND
Text Label 9900 3050 0    60   ~ 0
GND
$Comp
L Speaker LS1
U 1 1 5A561634
P 5300 1300
F 0 "LS1" H 5350 1525 50  0000 R CNN
F 1 "Speaker" H 5350 1450 50  0000 R CNN
F 2 "custom:SpeakerDigisoundSAL5050MC" H 5300 1100 50  0001 C CNN
F 3 "" H 5290 1250 50  0001 C CNN
	1    5300 1300
	0    -1   -1   0   
$EndComp
Text Label 5750 1700 0    60   ~ 0
GND
$Comp
L R R6
U 1 1 5A5883B2
P 7450 1750
F 0 "R6" V 7530 1750 50  0000 C CNN
F 1 "1175" V 7450 1750 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7380 1750 50  0001 C CNN
F 3 "" H 7450 1750 50  0001 C CNN
	1    7450 1750
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 5A5884E4
P 7450 1950
F 0 "R7" V 7530 1950 50  0000 C CNN
F 1 "1175" V 7450 1950 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7380 1950 50  0001 C CNN
F 3 "" H 7450 1950 50  0001 C CNN
	1    7450 1950
	0    1    1    0   
$EndComp
$Comp
L R R8
U 1 1 5A58854C
P 7450 2150
F 0 "R8" V 7530 2150 50  0000 C CNN
F 1 "1600" V 7450 2150 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7380 2150 50  0001 C CNN
F 3 "" H 7450 2150 50  0001 C CNN
	1    7450 2150
	0    1    1    0   
$EndComp
$Comp
L LED D1
U 1 1 5A588D7A
P 7700 4500
F 0 "D1" H 7700 4600 50  0000 C CNN
F 1 "LED" H 7700 4400 50  0000 C CNN
F 2 "LEDs:LED_0805_HandSoldering" H 7700 4500 50  0001 C CNN
F 3 "" H 7700 4500 50  0001 C CNN
	1    7700 4500
	-1   0    0    1   
$EndComp
$Comp
L R R5
U 1 1 5A5896FB
P 7300 4500
F 0 "R5" V 7380 4500 50  0000 C CNN
F 1 "220" V 7300 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7230 4500 50  0001 C CNN
F 3 "" H 7300 4500 50  0001 C CNN
	1    7300 4500
	0    1    1    0   
$EndComp
Text Label 8100 4500 0    60   ~ 0
GND
$Comp
L Motor_DC M1
U 1 1 5A58B6B5
P 7650 4100
F 0 "M1" V 7750 4200 50  0000 L CNN
F 1 "VibrationMotor" V 7800 3800 50  0000 L TNN
F 2 "custom:VibrationMotor17x5WithDrillHoles" H 7650 4010 50  0001 C CNN
F 3 "" H 7650 4010 50  0001 C CNN
	1    7650 4100
	0    -1   -1   0   
$EndComp
$Comp
L R R4
U 1 1 5A58B805
P 7250 4100
F 0 "R4" V 7330 4100 50  0000 C CNN
F 1 "22" V 7250 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7180 4100 50  0001 C CNN
F 3 "" H 7250 4100 50  0001 C CNN
	1    7250 4100
	0    1    1    0   
$EndComp
Text Label 8100 4100 0    60   ~ 0
GND
Text Label 6750 1150 0    60   ~ 0
5V
Text Label 6750 1800 0    60   ~ 0
GND
$Comp
L Crystal Y1
U 1 1 5A58FBFE
P 7350 3050
F 0 "Y1" V 7350 3200 50  0000 C CNN
F 1 "16MHz" V 7350 2800 50  0000 C CNN
F 2 "custom:Crystal_SMD_ABRACON_ABLS7M2" H 7350 3050 50  0001 C CNN
F 3 "" H 7350 3050 50  0001 C CNN
	1    7350 3050
	0    1    1    0   
$EndComp
$Comp
L C C5
U 1 1 5A5904B4
P 7800 2900
F 0 "C5" V 7850 3000 50  0000 L CNN
F 1 "22pF" V 7650 2800 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 7838 2750 50  0001 C CNN
F 3 "" H 7800 2900 50  0001 C CNN
	1    7800 2900
	0    -1   -1   0   
$EndComp
$Comp
L C C6
U 1 1 5A590531
P 7800 3200
F 0 "C6" V 7850 3300 50  0000 L CNN
F 1 "22pF" V 7650 3100 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 7838 3050 50  0001 C CNN
F 3 "" H 7800 3200 50  0001 C CNN
	1    7800 3200
	0    -1   -1   0   
$EndComp
Text Label 7950 2900 0    60   ~ 0
GND
Text Label 7950 3200 0    60   ~ 0
GND
$Comp
L R R3
U 1 1 5A593366
P 6850 3850
F 0 "R3" V 6930 3850 50  0000 C CNN
F 1 "10K" V 6850 3850 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6780 3850 50  0001 C CNN
F 3 "" H 6850 3850 50  0001 C CNN
	1    6850 3850
	0    1    1    0   
$EndComp
Text Label 7100 3850 0    60   ~ 0
5V
NoConn ~ 4250 3000
NoConn ~ 4250 3750
NoConn ~ 4250 3850
NoConn ~ 6150 4400
NoConn ~ 6150 4200
NoConn ~ 6150 4100
NoConn ~ 6150 4000
NoConn ~ 6150 3750
NoConn ~ 6150 3650
NoConn ~ 6150 3550
NoConn ~ 6150 3450
NoConn ~ 6150 3350
$Comp
L CP C9
U 1 1 5A594696
P 10350 3950
F 0 "C9" H 10375 4050 50  0000 L CNN
F 1 "22uF" H 10375 3850 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_6.3x5.8" H 10388 3800 50  0001 C CNN
F 3 "" H 10350 3950 50  0001 C CNN
	1    10350 3950
	-1   0    0    1   
$EndComp
NoConn ~ 9350 4050
NoConn ~ 9750 4350
$Comp
L CP C8
U 1 1 5A59B569
P 9900 3200
F 0 "C8" H 9925 3300 50  0000 L CNN
F 1 "1uF" H 9925 3100 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_4x5.3" H 9938 3050 50  0001 C CNN
F 3 "" H 9900 3200 50  0001 C CNN
	1    9900 3200
	-1   0    0    1   
$EndComp
Text Notes 7350 7500 0    60   ~ 0
Othering Machines\n
Text Notes 8100 7650 0    60   ~ 0
Januar 2018
$Comp
L PWR_FLAG #FLG02
U 1 1 5A71C869
P 1200 1350
F 0 "#FLG02" H 1200 1425 50  0001 C CNN
F 1 "PWR_FLAG" V 1200 1650 50  0000 C CNN
F 2 "" H 1200 1350 50  0001 C CNN
F 3 "" H 1200 1350 50  0001 C CNN
	1    1200 1350
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 5A71C98E
P 1200 1450
F 0 "#FLG03" H 1200 1525 50  0001 C CNN
F 1 "PWR_FLAG" V 1200 1750 50  0000 C CNN
F 2 "" H 1200 1450 50  0001 C CNN
F 3 "" H 1200 1450 50  0001 C CNN
	1    1200 1450
	0    1    1    0   
$EndComp
$Comp
L GND #PWR04
U 1 1 5A71CA35
P 1200 1450
F 0 "#PWR04" H 1200 1200 50  0001 C CNN
F 1 "GND" V 1200 1250 50  0000 C CNN
F 2 "" H 1200 1450 50  0001 C CNN
F 3 "" H 1200 1450 50  0001 C CNN
	1    1200 1450
	0    1    1    0   
$EndComp
$Comp
L GND #PWR05
U 1 1 5A71F074
P 950 3250
F 0 "#PWR05" H 950 3000 50  0001 C CNN
F 1 "GND" V 950 3050 50  0000 C CNN
F 2 "" H 950 3250 50  0001 C CNN
F 3 "" H 950 3250 50  0001 C CNN
	1    950  3250
	1    0    0    -1  
$EndComp
$Comp
L LED_RAGB D2
U 1 1 5AC36C4B
P 7950 1950
F 0 "D2" H 7950 2320 50  0000 C CNN
F 1 "LED_RAGB" H 7950 1600 50  0000 C CNN
F 2 "custom:LED_RCGB_AAA3528" H 7950 1900 50  0001 C CNN
F 3 "" H 7950 1900 50  0001 C CNN
	1    7950 1950
	1    0    0    -1  
$EndComp
Text Label 8150 1950 0    60   ~ 0
5V
NoConn ~ 6150 4700
$Comp
L MCP1640TIchy U1
U 1 1 5B009D96
P 2050 2250
F 0 "U1" H 2100 2550 50  0000 C CNN
F 1 "MCP1640TIchy" H 2050 2750 71  0000 C CNN
F 2 "custom:MCP1640TIchy" H 2050 1650 50  0001 C CNN
F 3 "" V 1850 2200 50  0001 C CNN
	1    2050 2250
	1    0    0    -1  
$EndComp
$Comp
L +2V5 #PWR06
U 1 1 5B009FBC
P 1200 1350
F 0 "#PWR06" H 1200 1200 50  0001 C CNN
F 1 "+2V5" V 1200 1600 50  0000 C CNN
F 2 "" H 1200 1350 50  0001 C CNN
F 3 "" H 1200 1350 50  0001 C CNN
	1    1200 1350
	0    -1   -1   0   
$EndComp
$Comp
L +2V5 #PWR07
U 1 1 5B00A0F7
P 1350 2950
F 0 "#PWR07" H 1350 2800 50  0001 C CNN
F 1 "+2V5" V 1350 3150 50  0000 C CNN
F 2 "" H 1350 2950 50  0001 C CNN
F 3 "" H 1350 2950 50  0001 C CNN
	1    1350 2950
	0    1    1    0   
$EndComp
Text Label 3300 2250 0    60   ~ 0
5V
$Comp
L R R1
U 1 1 5B00B6B8
P 2700 2400
F 0 "R1" V 2780 2400 50  0000 C CNN
F 1 "68K" V 2700 2400 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 2630 2400 50  0001 C CNN
F 3 "" H 2700 2400 50  0001 C CNN
	1    2700 2400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5B00B71F
P 2700 2700
F 0 "R2" V 2780 2700 50  0000 C CNN
F 1 "22K" V 2700 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 2630 2700 50  0001 C CNN
F 3 "" H 2700 2700 50  0001 C CNN
	1    2700 2700
	1    0    0    -1  
$EndComp
Text Label 2050 2700 3    60   ~ 0
GND
Text Label 2700 2850 3    60   ~ 0
GND
$Comp
L CP C1
U 1 1 5B00B931
P 1500 2400
F 0 "C1" V 1350 2350 50  0000 L CNN
F 1 "4.7uF" V 1650 2250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 1538 2250 50  0001 C CNN
F 3 "" H 1500 2400 50  0001 C CNN
	1    1500 2400
	1    0    0    -1  
$EndComp
$Comp
L L L1
U 1 1 5B00BA8C
P 1750 1900
F 0 "L1" V 1700 1900 50  0000 C CNN
F 1 "L" V 1825 1900 50  0000 C CNN
F 2 "Inductors_SMD:L_Abracon_ASPI-3012S" H 1750 1900 50  0001 C CNN
F 3 "" H 1750 1900 50  0001 C CNN
	1    1750 1900
	0    1    1    0   
$EndComp
$Comp
L CP C2
U 1 1 5B00BCE0
P 3100 2400
F 0 "C2" V 2950 2350 50  0000 L CNN
F 1 "10uF" V 3250 2250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3138 2250 50  0001 C CNN
F 3 "" H 3100 2400 50  0001 C CNN
	1    3100 2400
	1    0    0    -1  
$EndComp
Text Label 8950 4150 2    60   ~ 0
5V
Text Label 9550 5600 2    60   ~ 0
5V
Text Label 1500 2550 3    60   ~ 0
GND
$Comp
L CP C4
U 1 1 5B052897
P 4850 1700
F 0 "C4" H 4875 1800 50  0000 L CNN
F 1 "4.7uF" H 4875 1600 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_5x5.3" H 4888 1550 50  0001 C CNN
F 3 "" H 4850 1700 50  0001 C CNN
	1    4850 1700
	0    1    1    0   
$EndComp
Text Label 4700 1700 2    60   ~ 0
GND
Text Label 3100 2550 3    60   ~ 0
GND
$Comp
L CP C3
U 1 1 5B057583
P 3300 1550
F 0 "C3" H 3325 1650 50  0000 L CNN
F 1 "1000uF" H 3325 1450 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_10x10.5" H 3338 1400 50  0001 C CNN
F 3 "" H 3300 1550 50  0001 C CNN
	1    3300 1550
	1    0    0    -1  
$EndComp
Text Label 3300 1400 0    60   ~ 0
5V
Text Label 3300 1700 3    60   ~ 0
GND
$Comp
L SW_DPDT_x2 SW1
U 1 1 5B298F74
P 1150 2450
F 0 "SW1" H 1150 2620 50  0000 C CNN
F 1 "SW_DPDT_x2" H 1150 2250 50  0000 C CNN
F 2 "custom:switch_SMDslide_JS202011SCQN" H 1150 2450 50  0001 C CNN
F 3 "" H 1150 2450 50  0001 C CNN
	1    1150 2450
	0    1    1    0   
$EndComp
$Comp
L Battery BT1
U 1 1 5B299188
P 950 3050
F 0 "BT1" H 1050 3150 50  0000 L CNN
F 1 "ExtPwrSply" H 1050 3050 50  0000 L CNN
F 2 "custom:BatteryConnector" V 950 3110 50  0001 C CNN
F 3 "" V 950 3110 50  0001 C CNN
	1    950  3050
	1    0    0    -1  
$EndComp
$Comp
L Battery_Cell BT2
U 1 1 5B29928B
P 1350 3150
F 0 "BT2" H 1450 3250 50  0000 L CNN
F 1 "Battery_Cell" H 1450 3150 50  0000 L CNN
F 2 "custom:BatteryConnector" V 1350 3210 50  0001 C CNN
F 3 "" V 1350 3210 50  0001 C CNN
	1    1350 3150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5B299468
P 1350 3250
F 0 "#PWR08" H 1350 3000 50  0001 C CNN
F 1 "GND" V 1350 3050 50  0000 C CNN
F 2 "" H 1350 3250 50  0001 C CNN
F 3 "" H 1350 3250 50  0001 C CNN
	1    1350 3250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR09
U 1 1 5B299F83
P 950 2850
F 0 "#PWR09" H 950 2700 50  0001 C CNN
F 1 "VCC" H 950 3000 50  0000 C CNN
F 2 "" H 950 2850 50  0001 C CNN
F 3 "" H 950 2850 50  0001 C CNN
	1    950  2850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10350 4100 10100 4100
Wire Wire Line
	10100 4100 10100 4050
Wire Wire Line
	10100 4050 9950 4050
Wire Wire Line
	9950 3950 10100 3950
Wire Wire Line
	10100 3950 10100 3800
Wire Wire Line
	10100 3800 10350 3800
Wire Wire Line
	9550 4550 9550 4350
Wire Wire Line
	9550 5600 9550 5350
Wire Wire Line
	10050 4350 10050 4150
Wire Wire Line
	10050 4150 9950 4150
Wire Wire Line
	8950 4150 9350 4150
Wire Wire Line
	6600 4600 6150 4600
Wire Wire Line
	6150 2500 6900 2500
Wire Wire Line
	6900 2500 6900 2150
Wire Wire Line
	6150 2600 7000 2600
Wire Wire Line
	7000 2600 7000 1950
Wire Wire Line
	5400 1500 5400 1700
Wire Wire Line
	5400 1700 5750 1700
Wire Wire Line
	7100 1750 7300 1750
Wire Wire Line
	7600 1750 7750 1750
Wire Wire Line
	7600 1950 7750 1950
Wire Wire Line
	7600 2150 7750 2150
Wire Wire Line
	6900 2150 7300 2150
Wire Wire Line
	7000 1950 7300 1950
Wire Wire Line
	5300 1500 5300 2050
Wire Wire Line
	7450 4500 7550 4500
Wire Wire Line
	7150 4500 6150 4500
Wire Wire Line
	7850 4500 8100 4500
Wire Wire Line
	7400 4100 7450 4100
Wire Wire Line
	7100 4100 6850 4100
Wire Wire Line
	6850 4100 6850 4300
Wire Wire Line
	6850 4300 6150 4300
Wire Wire Line
	8100 4100 7950 4100
Wire Wire Line
	6400 1300 6250 1300
Wire Wire Line
	6250 1300 6250 2800
Wire Wire Line
	6250 2800 6150 2800
Wire Wire Line
	6400 1400 6300 1400
Wire Wire Line
	6300 1400 6300 2900
Wire Wire Line
	6300 2900 6150 2900
Wire Wire Line
	6650 1400 6800 1400
Wire Wire Line
	6800 1400 6800 1700
Wire Wire Line
	6800 1700 6350 1700
Wire Wire Line
	6350 1700 6350 2700
Wire Wire Line
	6350 2700 6150 2700
Wire Wire Line
	6400 1500 6400 3850
Wire Wire Line
	6150 3850 6700 3850
Wire Wire Line
	6650 1300 6650 1150
Wire Wire Line
	6650 1150 6750 1150
Wire Wire Line
	6650 1500 6650 1800
Wire Wire Line
	6650 1800 6750 1800
Wire Wire Line
	7100 2700 6600 2700
Wire Wire Line
	7100 1750 7100 2700
Connection ~ 10150 3350
Connection ~ 9900 3350
Wire Wire Line
	6700 2900 7650 2900
Wire Wire Line
	6700 2900 6700 3000
Wire Wire Line
	6700 3000 6150 3000
Wire Wire Line
	6700 3200 7650 3200
Wire Wire Line
	6700 3200 6700 3100
Wire Wire Line
	6700 3100 6150 3100
Connection ~ 7350 2900
Connection ~ 7350 3200
Wire Wire Line
	9650 3650 9650 3750
Wire Wire Line
	6600 2700 6600 4600
Wire Wire Line
	6150 3250 6550 3250
Wire Wire Line
	6550 3250 6550 3550
Wire Wire Line
	6550 3550 9150 3550
Wire Wire Line
	9150 3550 9150 3350
Wire Wire Line
	9150 3350 10150 3350
Connection ~ 9650 3350
Wire Wire Line
	7000 3850 7100 3850
Connection ~ 6400 3850
Wire Wire Line
	5300 2050 6150 2050
Wire Wire Line
	6150 2050 6150 2400
Wire Wire Line
	2350 2450 2500 2450
Wire Wire Line
	2500 2450 2500 2550
Wire Wire Line
	2500 2550 2700 2550
Wire Wire Line
	1750 2450 1700 2450
Wire Wire Line
	1700 2450 1700 2250
Connection ~ 1700 2250
Wire Wire Line
	1600 1900 1600 2250
Connection ~ 1600 2250
Wire Wire Line
	1950 1900 1900 1900
Wire Notes Line
	750  1250 750  3650
Wire Notes Line
	750  3650 3600 3650
Wire Notes Line
	3600 3650 3600 1250
Wire Notes Line
	3600 1250 750  1250
Wire Notes Line
	750  1700 1750 1700
Wire Notes Line
	1750 1700 1750 1250
Wire Wire Line
	2350 2250 3300 2250
Connection ~ 2700 2250
Connection ~ 3100 2250
Wire Wire Line
	1150 2250 1750 2250
Connection ~ 1500 2250
Wire Wire Line
	5000 1700 5300 1700
Connection ~ 5300 1700
Connection ~ 1150 2250
Wire Wire Line
	950  2850 1050 2850
Wire Wire Line
	1050 2850 1050 2650
Wire Wire Line
	1250 2650 1250 2850
Wire Wire Line
	1250 2850 1350 2850
Wire Wire Line
	1350 2850 1350 2950
Connection ~ 1350 2950
Wire Wire Line
	9550 4850 9550 5050
Connection ~ 9550 4900
Wire Wire Line
	9250 4900 9550 4900
$EndSCHEMATC
