//
//  ValueBand1.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

enum ValueBand1: Int, Band {
	case Clear	= -1
	case Black	= 0
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
	var bkgndDestRect: CGRect { return CGRectMake(160, 45, 21, 110) }

	// source in sprite
	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 323) // -1 clear
		case .Black:	return CGPointMake( 38, 323) // 0 black
		case .Brown:	return CGPointMake( 76, 323) // 1 brown
		case .Red:		return CGPointMake(114, 323) // 2 red
		case .Orange:	return CGPointMake(152, 323) // 3 orange
		case .Yellow:	return CGPointMake(190, 323) // 4 yellow
		case .Green:	return CGPointMake(227, 323) // 5 green
		case .Blue:		return CGPointMake(265, 323) // 6 blue
		case .Purple:	return CGPointMake(303, 323) // 7 purple
		case .Gray:		return CGPointMake(341, 323) // 8 gray
		case .White:	return CGPointMake(379, 323) // 9 white
		}
	}

	// decimal value of this color band
	var value: Double { return (self.rawValue >= 0) ? Double(self.rawValue) : 0.0 }

	//static var allValues: [Band] { return [Clear, Black, Brown, Red, Orange, Yellow, Green, Blue, Purple, Gray, White] }
}