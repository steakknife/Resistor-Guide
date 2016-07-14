//
//  EIAClassifier.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/22/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation

enum EIAClass: String {
	case E3, E6, E12, E24, E48, E96, E192

	typealias Mantissa = UInt16
	typealias Tolerance = UInt16
	private typealias Table = [Mantissa]
	private typealias TableIndex = Table.Index

	// E3, E6, E12, E24
	private static let e24Table: Table = [
		100, 110, 120, 130, 150, 160, 180, 200,
		220, 240, 270, 300, 330, 360, 390, 430,
		470, 510, 560, 620, 680, 750, 820, 910
	]

	// E48, E96, E192
	private static let e192Table: Table = [
		100, 101, 102, 104, 105, 106, 107, 109, 110, 111, 113, 114, 115, 117, 118, 120,
		121, 123, 124, 126, 127, 129, 130, 132, 133, 135, 137, 138, 140, 142, 143, 145,
		147, 149, 150, 152, 154, 156, 158, 160, 162, 164, 165, 167, 169, 172, 174, 176,
		178, 180, 182, 184, 187, 189, 191, 193, 196, 198, 200, 203, 205, 208, 210, 213,
		215, 218, 221, 223, 226, 229, 232, 234, 237, 240, 243, 246, 249, 252, 255, 258,
		261, 264, 267, 271, 274, 277, 280, 284, 287, 291, 294, 298, 301, 305, 309, 312,
		316, 320, 324, 328, 332, 336, 340, 344, 348, 352, 357, 361, 365, 370, 374, 379,
		383, 388, 392, 397, 402, 407, 412, 417, 422, 427, 432, 437, 442, 448, 453, 459,
		464, 470, 475, 481, 487, 493, 499, 505, 511, 517, 523, 530, 536, 542, 549, 556,
		562, 569, 576, 583, 590, 597, 604, 612, 619, 626, 634, 642, 649, 657, 665, 673,
		681, 690, 698, 706, 715, 723, 732, 741, 750, 759, 768, 777, 787, 796, 806, 816,
		825, 835, 845, 856, 866, 876, 887, 898, 909, 920, 931, 942, 953, 965, 976, 988,
	]


	private static func classifyZeroOhm(tolerance: Tolerance) -> EIAClass! {
		switch tolerance {
		case 50_00: return .E3
		case 20_00: return .E6
		case 10_00: return .E12
		case  5_00: return .E24
		case  2_00: return .E48
		case  1_00: return .E96
		default: return (tolerance <= 0_50 && tolerance > 0) ? .E192 : nil
		}
	}

	private static func classifyE3ToE24(tolerance: Tolerance, e24Idx: TableIndex) -> EIAClass! {
		if e24Idx % 8 == 0 {
			switch tolerance {
			case 50_00: return .E3
			case 20_00: return .E6
			case 10_00: return .E12
			case  5_00: return .E24
			default: break
			}
		} else if e24Idx % 4 == 0 {
			switch tolerance {
			case 20_00: return .E6
			case 10_00: return .E12
			case  5_00: return .E24
			default: break
			}
		} else if e24Idx % 2 == 0 {
			switch tolerance {
			case 10_00: return .E12
			case  5_00: return .E24
			default: break
			}
		} else {
			if tolerance == 5_00 {
				return .E24
			}
		}
		return nil
	}

	private static func classifyE48ToE192(tolerance: Tolerance, e192Idx: TableIndex) -> EIAClass! {
		if e192Idx % 4 == 0 {
			switch tolerance {
			case  2_00: return .E48
			case  1_00: return .E96
			default: return (tolerance <= 0_50 && tolerance > 0) ? .E192 : nil
			}
		} else if e192Idx % 2 == 0 {
			switch tolerance {
			case  1_00: return .E96
			default: return (tolerance <= 0_50 && tolerance > 0) ? .E192 : nil
			}
		} else {
			return (tolerance <= 0_50 && tolerance > 0) ? .E192 : nil
		}
	}

	static func classify(mantissa: Mantissa, tolerance: Tolerance) -> EIAClass! {
		if mantissa == 0 {
			return classifyZeroOhm(tolerance)
		}

		let e24Idx = binarySearch(e24Table, findElem: mantissa)
		if e24Idx != e24Table.endIndex {
			if let eia = classifyE3ToE24(tolerance, e24Idx: e24Idx)  {
				return eia
			}
		}

		let e192Idx = binarySearch(e192Table, findElem: mantissa)
		if e192Idx != e192Table.endIndex {
			return classifyE48ToE192(tolerance, e192Idx: e192Idx)
		}

		return nil
	}

	var description: String { return rawValue }
}