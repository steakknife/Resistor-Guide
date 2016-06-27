//
//  AlternateToleranceBand4.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/26/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

// Not strictly a "model" because of mixing sprite values, but it collapses a pointless view since we're using sprites
enum TemperatureCoefficientBand5: Int, Band {
	case Clear	=   -1
	case Brown	=  100 // ppm/ºC
	case Red	=   50 // ppm/ºC
//	case Yellow	=   25 // ppm/ºC TODO: needs lower-left sprite filtered to yellow
//	case Orange	=   15 // ppm/ºC TODO: needs lower-left sprite filtered to orange
	case Blue   =   10 // ppm/ºC
	case Purple =    5 // ppm/ºC
//  case White  =    1 // ppm/ºC TODO: needs lower-left sprite filtered to yellow

	var bkgndDestRect: CGRect { return CGRectMake(293, 40, 34, 120) }

	var spriteSourceOrigin: CGPoint {
		switch self {
		case .Clear:	return CGPointMake(  0, 552)
		case .Brown:	return CGPointMake(183, 552)
		case .Red:		return CGPointMake(229, 552)
//		case .Yellow:	return CGPointMake(   ,    ) TODO
//		case .Orange:	return CGPointMake(   ,    ) TODO
		case .Blue:		return CGPointMake( 92, 552)
		case .Purple:	return CGPointMake( 46, 552)
//		case .White:	return CGPointMake(   ,    ) TODO
		}
	}
}