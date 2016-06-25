//
//  ValueBand0.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

enum ValueBand0: Int, Band {
	case Clear	= 0
	// Black isn't standard for the first digit
	case Brown	= 1
	case Red	= 2
	case Orange = 3
	case Yellow = 4
	case Green	= 5
	case Blue	= 6
	case Purple = 7
	case Gray	= 8
	case White	= 9

	// destination onto background
	var bkgndDestRect: CGRect { return CGRectMake(119, 41, 25, 118) }

	// source in sprite
	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 200) // -1 clear
		case .Brown:	return CGPointMake( 42, 200) // 1 brown
		case .Red:		return CGPointMake( 83, 200) // 2 red
		case .Orange:	return CGPointMake(125, 200) // 3 orange
		case .Yellow:	return CGPointMake(167, 200) // 4 yellow
		case .Green:	return CGPointMake(208, 200) // 5 green
		case .Blue:		return CGPointMake(250, 200) // 6 blue
		case .Purple:	return CGPointMake(292, 200) // 7 purple
		case .Gray:		return CGPointMake(333, 200) // 8 gray
		case .White:	return CGPointMake(375, 200) // 9 white
		}
	}

	// decimal value of this color band
	var value: Double { return Double(self.rawValue) }

	//static var allValues: [Band] { return [Clear, Brown, Red, Orange, Yellow, Green, Blue, Purple, Gray, White] }
}
