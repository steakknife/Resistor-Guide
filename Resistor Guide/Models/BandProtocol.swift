//
//  BandProtocol.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Band {
	var bkgndDestRect: CGRect { get }
	var spriteSourceOrigin: CGPoint { get }
}

extension Band {
	var spriteSourceRect: CGRect {
		return CGRect(origin: spriteSourceOrigin, size: bkgndDestRect.size)
	}
}


