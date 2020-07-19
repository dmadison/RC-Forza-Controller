EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "Dumbo RC CH5/6 Button Daughterboard"
Date "2020-02-25"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 5E553F35
P 6100 4100
F 0 "J1" H 6180 4092 50  0000 L CNN
F 1 "Conn_01x04" H 6180 4001 50  0000 L CNN
F 2 "Connector_JST:JST_PH_B4B-PH-K_1x04_P2.00mm_Vertical" H 6100 4100 50  0001 C CNN
F 3 "~" H 6100 4100 50  0001 C CNN
	1    6100 4100
	1    0    0    -1  
$EndComp
Text Label 5900 4000 2    50   ~ 0
3V3
Wire Wire Line
	5750 4200 5900 4200
Text Label 5900 4100 2    50   ~ 0
CH5
Text Label 5750 4200 0    50   ~ 0
GND
Text Label 5900 4300 2    50   ~ 0
CH6
$Comp
L Switch:SW_Push SW1
U 1 1 5E555AD4
P 5150 4100
F 0 "SW1" H 5150 4385 50  0000 C CNN
F 1 "SW_Push" H 5150 4294 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 5150 4300 50  0001 C CNN
F 3 "~" H 5150 4300 50  0001 C CNN
	1    5150 4100
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5E55641B
P 5150 4300
F 0 "SW2" H 5150 4200 50  0000 C CNN
F 1 "SW_Push" H 5150 4100 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 5150 4500 50  0001 C CNN
F 3 "~" H 5150 4500 50  0001 C CNN
	1    5150 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5E556B0B
P 4350 4000
F 0 "R2" H 4420 4046 50  0000 L CNN
F 1 "10k" H 4420 3955 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4280 4000 50  0001 C CNN
F 3 "~" H 4350 4000 50  0001 C CNN
	1    4350 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4000 5500 3700
Wire Wire Line
	5500 3700 4800 3700
Wire Wire Line
	4800 4300 4950 4300
Wire Wire Line
	4950 4100 4800 4100
$Comp
L Device:R R1
U 1 1 5E5573AC
P 4050 4000
F 0 "R1" H 4120 4046 50  0000 L CNN
F 1 "10k" H 4120 3955 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3980 4000 50  0001 C CNN
F 3 "~" H 4050 4000 50  0001 C CNN
	1    4050 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3700 4800 4100
Connection ~ 4800 4100
Wire Wire Line
	4800 4100 4800 4300
Wire Wire Line
	5350 4300 5900 4300
Wire Wire Line
	5350 4100 5900 4100
Wire Wire Line
	5500 4000 5900 4000
Wire Wire Line
	4050 4150 4050 4200
Wire Wire Line
	4050 4200 4200 4200
Wire Wire Line
	4350 4200 4350 4150
Wire Wire Line
	4200 4200 4200 4300
Connection ~ 4200 4200
Wire Wire Line
	4200 4200 4350 4200
Wire Wire Line
	4350 3850 4350 3750
Wire Wire Line
	4050 3850 4050 3750
Text Label 4350 3750 0    50   ~ 0
CH6
Text Label 4050 3750 0    50   ~ 0
CH5
$Comp
L power:GND #PWR01
U 1 1 5E56E46B
P 4200 4300
F 0 "#PWR01" H 4200 4050 50  0001 C CNN
F 1 "GND" H 4205 4127 50  0000 C CNN
F 2 "" H 4200 4300 50  0001 C CNN
F 3 "" H 4200 4300 50  0001 C CNN
	1    4200 4300
	1    0    0    -1  
$EndComp
Text Label 3700 3850 3    50   ~ 0
GND
Wire Wire Line
	3700 4050 3700 3850
Text Label 3550 3850 3    50   ~ 0
3V3
Wire Wire Line
	3550 4050 3550 3850
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5E575C57
P 3550 4050
F 0 "#FLG01" H 3550 4125 50  0001 C CNN
F 1 "PWR_FLAG" H 3450 4250 50  0000 C CNN
F 2 "" H 3550 4050 50  0001 C CNN
F 3 "~" H 3550 4050 50  0001 C CNN
	1    3550 4050
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5E5748AC
P 3700 4050
F 0 "#FLG02" H 3700 4125 50  0001 C CNN
F 1 "PWR_FLAG" H 3700 4223 50  0001 C CNN
F 2 "" H 3700 4050 50  0001 C CNN
F 3 "~" H 3700 4050 50  0001 C CNN
	1    3700 4050
	-1   0    0    1   
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5E59D1E0
P 10000 6450
F 0 "H1" H 10100 6500 50  0001 L CNN
F 1 "MountingHole" H 9350 6450 50  0000 L CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10000 6450 50  0001 C CNN
F 3 "~" H 10000 6450 50  0001 C CNN
	1    10000 6450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5E59DB06
P 10200 6450
F 0 "H2" H 10300 6500 50  0001 L CNN
F 1 "MountingHole" H 9550 6450 50  0001 L CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10200 6450 50  0001 C CNN
F 3 "~" H 10200 6450 50  0001 C CNN
	1    10200 6450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5E59E046
P 10400 6450
F 0 "H3" H 10500 6500 50  0001 L CNN
F 1 "MountingHole" H 9750 6450 50  0001 L CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10400 6450 50  0001 C CNN
F 3 "~" H 10400 6450 50  0001 C CNN
	1    10400 6450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5E59E26D
P 10000 6650
F 0 "H4" H 10100 6700 50  0001 L CNN
F 1 "AlignmentHole" H 9350 6650 50  0000 L CNN
F 2 "DumboRC_Daughterboards:AlignmentHole_1.25mm" H 10000 6650 50  0001 C CNN
F 3 "~" H 10000 6650 50  0001 C CNN
	1    10000 6650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 5E59E8BD
P 10200 6650
F 0 "H5" H 10300 6700 50  0001 L CNN
F 1 "AlignmentHole" H 9550 6650 50  0001 L CNN
F 2 "DumboRC_Daughterboards:AlignmentHole_1.25mm" H 10200 6650 50  0001 C CNN
F 3 "~" H 10200 6650 50  0001 C CNN
	1    10200 6650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 5E59EDE0
P 10400 6650
F 0 "H6" H 10500 6700 50  0001 L CNN
F 1 "AlignmentHole" H 9750 6650 50  0001 L CNN
F 2 "DumboRC_Daughterboards:AlignmentHole_1.25mm" H 10400 6650 50  0001 C CNN
F 3 "~" H 10400 6650 50  0001 C CNN
	1    10400 6650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
