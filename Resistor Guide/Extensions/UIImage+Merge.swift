//
//  UIImage+Merge.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
	func mergeMany(topImages: [(UIImage, CGPoint)]) -> UIImage! {
		UIGraphicsBeginImageContext(size)

		// start drawing

		drawAtPoint(CGPointZero)
		for (img, at) in topImages {
			img.drawAtPoint(at)
		}

		// finish drawing

		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return result
	}

	func mergeMany(topImages: [UIImage]) -> UIImage! {
		UIGraphicsBeginImageContext(size)

		// start drawing

		drawAtPoint(CGPointZero)
		for img in topImages {
			img.drawAtPoint(CGPointZero)
		}

		// finish drawing

		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return result
	}

	func merge(topImage: UIImage, at: CGPoint) -> UIImage! {
		UIGraphicsBeginImageContext(size)

		// start drawing

		drawAtPoint(CGPointZero)
		topImage.drawAtPoint(at)

		// finish drawing

		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return result
	}

	func merge(topImage: UIImage) -> UIImage! {
		return merge(topImage, at: CGPointZero)
	}
}