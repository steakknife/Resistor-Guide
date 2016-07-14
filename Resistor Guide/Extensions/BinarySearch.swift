//
//  BinarySearch.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/22/16.
//  Copyright © 2016 BMF. All rights reserved.
//

// TODO: needs major refactoring for Swift 3.0

import Foundation

func binarySearch<T: Comparable, C: CollectionType where C.Index: BidirectionalIndexType, C.Generator.Element == T, C.Index: Comparable> (collection: C, findElem: T) -> C.Index {
	var lowerIndex: C.Index = collection.startIndex
	var upperIndex: C.Index = collection.endIndex.predecessor()

	while lowerIndex <= upperIndex {
		let bisectionDistance: C.Index.Distance = lowerIndex.distanceTo(upperIndex) / 2
		let bisectionIndex: C.Index = lowerIndex.advancedBy(bisectionDistance)
		// middle half between upper and lower
		let bisectionElement: T = collection[bisectionIndex]
		if bisectionElement == findElem { // found
			return bisectionIndex
		} else { // not found: skip bisectionElement on next iteration
			if bisectionElement > findElem {
				upperIndex = bisectionIndex.predecessor()
			} else { // bisectionElement < findElem
				lowerIndex = bisectionIndex.successor()
			}
		}
	}
	return collection.endIndex
}