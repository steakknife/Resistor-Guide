//
//  EnumCollection.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/21/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation

func enumValues<T: Hashable>(x: T.Type) -> [T] {
	return iterateEnum(x).map { $0 }
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
	var i = 0
	return AnyGenerator {
		let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
		if next.hashValue == i {
			i += 1
			return next
		} else {
			return nil
		}
	}
}

func increment<T: Hashable> (x: T) -> T {
	let allValues = enumValues(T)

	var found = false
	for elem: T in allValues {
		if found {
			return elem
		}
		if elem == x {
			found = true
		}
	}
	return allValues.first!
}

func decrement<T: Hashable> (x: T) -> T {
	let allValues = enumValues(T)
	var prev: T! = allValues.last!
	for elem: T in allValues {
		if elem == x {
			return prev
		}
		prev = elem
	}
	return allValues.first!
}