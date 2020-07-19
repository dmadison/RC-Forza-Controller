EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "Dumbo RC CH3 Momentary Button Daughterboard"
Date "2020-02-25"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R1
U 1 1 5E557EF7
P 5500 3650
F 0 "R1" H 5570 3696 50  0000 L CNN
F 1 "330 Ω" H 5570 3605 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5430 3650 50  0001 C CNN
F 3 "~" H 5500 3650 50  0001 C CNN
	1    5500 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 5E559E63
P 6350 4400
F 0 "J1" H 6430 4442 50  0000 L CNN
F 1 "Conn_01x03" H 6430 4351 50  0000 L CNN
F 2 "Connector_JST:JST_PH_B3B-PH-K_1x03_P2.00mm_Vertical" H 6350 4400 50  0001 C CNN
F 3 "~" H 6350 4400 50  0001 C CNN
	1    6350 4400
	1    0    0    -1  
$EndComp
Text Label 6150 4300 2    50   ~ 0
3V3
Text Label 6150 4400 2    50   ~ 0
CH3
Text Label 6150 4500 2    50   ~ 0
GND
$Comp
L Device:LED D1
U 1 1 5E564FE2
P 5150 3650
F 0 "D1" V 5189 3533 50  0000 R CNN
F 1 "LED" V 5098 3533 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric" H 5150 3650 50  0001 C CNN
F 3 "~" H 5150 3650 50  0001 C CNN
	1    5150 3650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5500 4300 5500 3800
Wire Wire Line
	5500 4300 6150 4300
Wire Wire Line
	5150 3800 5150 3900
Wire Wire Line
	5350 4400 5350 3900
Wire Wire Line
	5350 3900 5150 3900
Wire Wire Line
	5350 4400 6150 4400
Connection ~ 5150 3900
Wire Wire Line
	5150 3900 5150 4000
Wire Wire Line
	5150 4400 5150 4500
Wire Wire Line
	5150 4500 6150 4500
$Comp
L Switch:SW_Push SW1
U 1 1 5E557151
P 5150 4200
F 0 "SW1" V 5104 4348 50  0000 L CNN
F 1 "SW_Push" V 5195 4348 50  0000 L CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 5150 4400 50  0001 C CNN
F 3 "https://dznh3ojzb2azq.cloudfront.net/products/Tactile/PTS645/documents/datasheet.pdf" H 5150 4400 50  0001 C CNN
F 4 "PTS645SL50SMTR92 LFS" V 5150 4200 50  0001 C CNN "Part Number"
	1    5150 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5150 3400 5150 3500
Wire Wire Line
	5500 3500 5500 3400
Wire Wire Line
	5500 3400 5150 3400
$Comp
L Mechanical:MountingHole H1
U 1 1 5E599EB4
P 10000 6400
F 0 "H1" H 10100 6446 50  0001 L CNN
F 1 "MountingHole" H 9850 6400 50  0000 R CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10000 6400 50  0001 C CNN
F 3 "~" H 10000 6400 50  0001 C CNN
	1    10000 6400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5E59B834
P 10200 6400
F 0 "H2" H 10300 6446 50  0001 L CNN
F 1 "MountingHole" H 10150 6550 50  0001 L CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10200 6400 50  0001 C CNN
F 3 "~" H 10200 6400 50  0001 C CNN
	1    10200 6400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5E59BC36
P 10400 6400
F 0 "H3" H 10500 6446 50  0001 L CNN
F 1 "MountingHole" H 10350 6550 50  0001 L CNN
F 2 "DumboRC_Daughterboards:MountingHole_2.25mm" H 10400 6400 50  0001 C CNN
F 3 "~" H 10400 6400 50  0001 C CNN
	1    10400 6400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 5E8D80BF
P 10400 6600
F 0 "H5" H 10500 6646 50  0001 L CNN
F 1 "AlignmentHole" H 10350 6750 50  0001 L CNN
F 2 "DumboRC_Daughterboards:AlignmentHole_1.25mm" H 10400 6600 50  0001 C CNN
F 3 "~" H 10400 6600 50  0001 C CNN
	1    10400 6600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5E8D8CBA
P 10000 6600
F 0 "H4" H 10100 6646 50  0001 L CNN
F 1 "AlignmentHole" H 9850 6600 50  0000 R CNN
F 2 "DumboRC_Daughterboards:AlignmentHole_1.25mm" H 10000 6600 50  0001 C CNN
F 3 "~" H 10000 6600 50  0001 C CNN
	1    10000 6600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
