//
//  ExponentBand2.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

// Not strictly a "model" because of mixing sprite values, but it collapses a pointless view since we're using sprites
enum ExponentBand2: Int, Band {
	case Clear	= -2 // 10^0
	case Silver =  0 // 10^-2
	case Gold	=  1 // 10^-1
	case Black	=  2 // 10^0
	case Brown	=  3 // 10^1
	case Red	=  4 // 10^2
	case Orange =  5 // 10^3
	case Yellow	=  6 // 10^4
	case Green	=  7 // 10^5
	case Blue	=  8 // 10^6    1M
	case Purple =  9 // 10^7   10M
	case Gray   = 10 // 10^8  100M
	case White  = 11 // 10^9    1G

	var bkgndDestRect: CGRect { return CGRectMake(199, 47, 20, 107) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 439)
		case .Silver:	return CGPointMake( 42, 439)
		case .Gold:		return CGPointMake( 84, 439)
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

	private var value: Double { return Double(abs(rawValue)) }

	var exponent: Double { return value - Double(Black.rawValue) }
}