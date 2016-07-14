//
//  String+Regex.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/28/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation

extension NSRegularExpressionOptions {
	static let Default = NSRegularExpressionOptions(rawValue: 0)
}

extension NSMatchingOptions {
	static let Default = NSMatchingOptions(rawValue: 0)
}

extension String {
	var nsrange: NSRange { return NSMakeRange(0, startIndex.distanceTo(endIndex)) }

	// Cocoa NSRange to Swift Foundation Range<String.Index>
	func subrange(range: NSRange) -> Range<Index> {
		let begin = startIndex.advancedBy(range.location)
		let end = begin.advancedBy(range.length)
		return begin..<end
	}

	func matches(pattern: String, regexOptions: NSRegularExpressionOptions = .Default, matchOptions: NSMatchingOptions = .Default, range: NSRange! = nil) -> [String]!
	{
		if let rngs = matchesAsRanges(pattern, regexOptions: regexOptions, matchOptions: matchOptions, range: range) {
			return rngs.map { self[$0] }
		}
		return nil
	}

	func matchesAsRanges(pattern: String, regexOptions: NSRegularExpressionOptions = .Default, matchOptions: NSMatchingOptions = .Default, range: NSRange! = nil) -> [Range<Index>]!
	{
		do {
			let regex = try NSRegularExpression(pattern: pattern, options: regexOptions)
			let rawResults: [NSTextCheckingResult] = regex.matchesInString(self, options: matchOptions, range: range ?? nsrange)
			let filteredResults = rawResults.map { subrange($0.range) }
			return filteredResults
		} catch {
			NSException.raise(NSInvalidArgumentException, format: "matchesAsRanges: error compiling NSRegularExpression '\(pattern)'", arguments: getVaList([]))
			return nil
		}
	}

	// returns nil if pattern is bad, or a copy of self with any replacements
	func replaceMatches(pattern: String, regexOptions: NSRegularExpressionOptions = .Default, matchOptions: NSMatchingOptions = .Default, range: NSRange! = nil, template: String) -> String! {
		do {
			let regex = try NSRegularExpression(pattern: pattern, options: regexOptions)
			let result = regex.stringByReplacingMatchesInString(self, options: matchOptions, range: range ?? nsrange, withTemplate: template)
			return result
		} catch {
			NSException.raise(NSInvalidArgumentException, format: "replaceMatches: error compiling NSRegularExpression '\(pattern)'", arguments: getVaList([]))
			return nil
		}
	}
}