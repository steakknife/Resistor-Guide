//
//  ToleranceBand4.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

// Not strictly a "model" because of mixing sprite values, but it collapses a pointless view since we're using sprites
// in hundreds of percents
enum ToleranceBand4: Int, Band {
	case Clear	= -20_00 //   E6
	case Black	=  20_00 //   E6
	case Silver =  10_00 // K E12
	case Gold	=   5_00 // J E24
	case Yellow =   4_00 //
	case Orange =   3_00 //
	case Red	=   2_00 // G E48
	case Brown	=   1_00 // F E96
	case Green	=   0_50 // D E192
	case Blue	=   0_25 // C E192
//	case Purple =   0_10 // B E192 TODO: needs lower-right sprite filtered to purple
//	case Gray	=   0_05 //        TODO: needs lower-right sprite filtered to gray

	var bkgndDestRect: CGRect { return CGRectMake(270, 41, 28, 118) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(547, 438) // empty area
		case .Black:	return CGPointMake(445, 552)
		case .Silver:	return CGPointMake(723, 552)
		case .Gold:		return CGPointMake(402, 552)
		case .Yellow:	return CGPointMake(627, 552)
		case .Orange:	return CGPointMake(579, 552)
		case .Red:		return CGPointMake(530, 552)
		case .Brown:	return CGPointMake(482, 552)
		case .Green:	return CGPointMake(675, 552)
		case .Blue:		return CGPointMake(771, 552)
//		case .Purple:	return CGPointMake( , ) // TODO
//		case .Gray:		return CGPointMake( , ) // TODO
		}
	}

	// hundreds of percents: 0-2000
	var tolerance: UInt { return UInt(abs(rawValue)) }

	// be sure to round to .01: 0-100
	var percent: Double { return Double(tolerance) / 100.0 }
}