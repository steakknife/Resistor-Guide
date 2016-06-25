//
//  ToleranceBand4.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

// in hundreds of percents
enum ToleranceBand4: Int, Band {
	case Clear	= -20_00 //   E6
	case Black	=  20_00 //   E6
	case Silver =  10_00 // K E12
	case Gold	=   5_00 // J E24
	case Red	=   2_00 // G E48
	case Brown	=   1_00 // F E96
	case Green	=   0_50 // D E192
	case Blue	=   0_25 // C E192
	case Purple =   0_10 // B E192
	case Gray	=   0_05 //

	var bkgndDestRect: CGRect { return CGRectMake(293, 40, 34, 120) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 552)
		case .Black:	return CGPointMake(366, 552)
		case .Silver:	return CGPointMake(320, 552)
		case .Gold:		return CGPointMake(275, 552)
		case .Red:		return CGPointMake(229, 552)
		case .Brown:	return CGPointMake(183, 552)
		case .Green:	return CGPointMake(137, 552)
		case .Blue:		return CGPointMake( 92, 552)
		case .Purple:	return CGPointMake( 46, 552)
		case .Gray:		return CGPointMake(698, 426)
		}
	}

	// hundreds of percents: 0-2000
	var tolerance: UInt { return UInt(abs(rawValue)) }

	// be sure to round to .01: 0-100
	var percent: Double { return Double(tolerance) / 100.0 }

	//static var allValues: [Band] { return [Clear, Black, Silver, Gold, Red, Brown, Green, Blue, Purple, Gray] }
}