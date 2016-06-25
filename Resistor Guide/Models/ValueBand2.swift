//
//  ValueBand2.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

enum ValueBand2: Int, Band {
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

	var bkgndDestRect: CGRect { return CGRectMake(199, 47, 20, 107) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 439)
		case .Black:	return CGPointMake(127, 439)
		case .Brown:	return CGPointMake(169, 439)
		case .Red:		return CGPointMake(211, 439)
		case .Orange:	return CGPointMake(253, 439)
		case .Yellow:	return CGPointMake(296, 439)
		case .Green:	return CGPointMake(338, 439)
		case .Blue:		return CGPointMake(380, 439)
		case .Purple:	return CGPointMake(449, 439)
		case .Gray:		return CGPointMake(416, 439)
		case .White:	return CGPointMake(481, 439)
		}
	}

	// decimal value of this color band
	var value: Double { return (self.rawValue >= 0) ? Double(self.rawValue) : 0.0 }

	//static let allValues = enumValues(ValueBand2)
}