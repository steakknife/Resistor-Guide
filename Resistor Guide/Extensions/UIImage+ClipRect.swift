//
//  UIImage+ClipRect.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
	public func clip(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIImage {
		return clip(CGRectMake(x, y, width, height))
	}

	public func clip(rect: CGRect) -> UIImage {
		return UIImage.init(CGImage: CGImageCreateWithImageInRect(self.CGImage, rect)!)
	}
}