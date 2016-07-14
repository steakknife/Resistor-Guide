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
		for (img, at): (UIImage, CGPoint) in topImages {
			img.drawAtPoint(at)
		}

		// finish drawing

		let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return result
	}

	func mergeMany(topImages: [UIImage]) -> UIImage! {
		let imgs: [(UIImage, CGPoint)] = topImages.map { ($0, CGPointZero) }
		return mergeMany(imgs)
	}

	func merge(topImage: UIImage, at: CGPoint = CGPointZero) -> UIImage! {
		let imgs: [(UIImage, CGPoint)] = [(topImage, at)]
		return mergeMany(imgs)
	}
}