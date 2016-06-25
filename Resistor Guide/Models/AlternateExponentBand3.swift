//
//  AlternateExponentBand3.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

enum AlternateExponentBand3: Int, Band {
	case Clear	= -2 // 10^0    1
	case Silver = 0  // 10^-2    .01
	case Gold	= 1  // 10^-1    .1
	case Black	= 2  // 10^0    1
	case Brown	= 3  // 10^1   10
	case Red	= 4  // 10^2  100
	case Orange = 5  // 10^3    1K
	case Yellow	= 6  // 10^4   10K
	case Green	= 7  // 10^5  100K
	case Blue	= 8  // 10^6    1M
	case Purple = 9  // 10^7   10M

	var bkgndDestRect: CGRect { return CGRectMake(236, 44, 21, 112) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(745, 200)
		case .Silver:	return CGPointMake(440, 200)
		case .Gold:		return CGPointMake(406, 200)
		case .Black:	return CGPointMake(779, 326)
		case .Brown:	return CGPointMake(474, 200)
		case .Red:		return CGPointMake(508, 200)
		case .Orange:	return CGPointMake(542, 200)
		case .Yellow:	return CGPointMake(576, 200)
		case .Green:	return CGPointMake(609, 200)
		case .Blue:		return CGPointMake(643, 200)
		case .Purple:	return CGPointMake(677, 200)
		}
	}

	private var value: Double { return Double(abs(rawValue)) }

	var exponent: Double { return value - Double(Black.rawValue) }

	//static var allValues: [Band] { return [Clear, Silver, Gold, Black, Brown, Red, Orange, Yellow, Green, Blue, Purple] }
}