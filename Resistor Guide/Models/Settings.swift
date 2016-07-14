//
//  Settings.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/30/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import Foundation

struct Settings {
	private static let defaults: [String:AnyObject] = [
		"band_count": 3,
		"band0": ValueBand0.Brown.rawValue,
		"band1": ValueBand1.Black.rawValue,
		"value_band2": ValueBand2.Black.rawValue,
		"exponent_band": ExponentBand2.Black.rawValue,
		// band3 is also just the exponent, so value_band2 is used
		"band4": ToleranceBand4.Red.rawValue,
		"band5": TemperatureCoefficientBand5.Red.rawValue
	]

	private static let band0Key = "band0"
	private static let band1Key = "band1"
	private static let valueBand2Key = "value_band2"
	private static let exponentBandKey = "exponent_band"
	private static let band4Key = "band4"
	private static let band5Key = "band5"
	private static let bandCountKey = "band_count"
	private static let preferIndoArabicNumeralsKey = "prefer_indo_arabic_numerals_preference"

	// Settings is a singleton
	private init() {}

	static func listenForChanges(observer: AnyObject, selector: Selector) {
		NSNotificationCenter.defaultCenter().addObserver(observer,
		                                                 selector: selector,
		                                                 name: NSUserDefaultsDidChangeNotification,
		                                                 object: nil)
	}

	static func registerNSUserDefaults() {
		NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
	}

	static var band0RawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(band0Key) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: band0Key) }
	}

	static var band1RawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(band1Key) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: band1Key) }
	}

	static var valueBand2RawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(valueBand2Key) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: valueBand2Key) }
	}

	static var exponentBandRawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(exponentBandKey) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: exponentBandKey) }
	}

	static var band4RawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(band4Key) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: band4Key) }
	}

	static var band5RawValue: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(band5Key) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: band5Key) }
	}

	static var bandCount: Int {
		get { return NSUserDefaults.standardUserDefaults().integerForKey(bandCountKey) }
		set { NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: bandCountKey) }
	}

	static var preferIndoArabicNumerals: Bool {
		return NSUserDefaults.standardUserDefaults().boolForKey(preferIndoArabicNumeralsKey)
	}

	private static func localizeNumeralsLocale(locale: NSLocale) -> NSLocale {
		if !preferIndoArabicNumerals {
			// print("native locale \(locale.localeIdentifier)")
			return locale
		}

		// Indo-Arabic numerals
		let localeId = locale.localeIdentifier
		var newId: String
		// ^[^_]+_(.+) -> en_\1
		if localeId.matches("_")!.count > 0 {
			newId = localeId.replaceMatches("^[^_]+_", template: "en_")!
		} else { // ^[^_]+$ -> en
			newId = "en"
		}

		// print("Indo-Arabic-numeralized locale: '\(locale.localeIdentifier)' ->  '\(newId)'")
		return NSLocale(localeIdentifier: newId)
	}
	
	static func nsNumberFormatterFactory() -> NSNumberFormatter {
		let fmt = NSNumberFormatter()
		fmt.minimumIntegerDigits = 1
		fmt.locale = localizeNumeralsLocale(fmt.locale)
		return fmt
	}
}