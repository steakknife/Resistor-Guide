//
//  Band.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

// Not strictly a "model" because of mixing sprite values, but it collapses a pointless view since we're using sprites
protocol Band {
	var bkgndDestRect: CGRect { get }
	var spriteSourceOrigin: CGPoint { get }
}

extension Band {
	var spriteSourceRect: CGRect {
		return CGRect(origin: spriteSourceOrigin, size: bkgndDestRect.size)
	}
}


