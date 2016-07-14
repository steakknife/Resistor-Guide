//
//  ViewController.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

	let debug: Bool = false

	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var resistorBackgroundView: UIImageView!
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var valueLabelButton: UIButton!
	@IBOutlet weak var space0: UIView!
	@IBOutlet weak var band0IncrementButton: UIButton!
	@IBOutlet weak var band0DecrementButton: UIButton!
	@IBOutlet weak var space01: UIView!
	@IBOutlet weak var band1IncrementButton: UIButton!
	@IBOutlet weak var band1DecrementButton: UIButton!
	@IBOutlet weak var space12: UIView!
	@IBOutlet weak var band2IncrementButton: UIButton!
	@IBOutlet weak var band2DecrementButton: UIButton!
	@IBOutlet weak var space23: UIView!
	@IBOutlet weak var band3IncrementButton: UIButton!
	@IBOutlet weak var band3DecrementButton: UIButton!
	@IBOutlet weak var space34: UIView!
	@IBOutlet weak var band4IncrementButton: UIButton!
	@IBOutlet weak var band4DecrementButton: UIButton!
	@IBOutlet weak var space45: UIView!
	@IBOutlet weak var band5IncrementButton: UIButton!
	@IBOutlet weak var band5DecrementButton: UIButton!
	@IBOutlet weak var segmentsSegment: UISegmentedControl!

	// **********************

	override func viewDidLoad() {
		super.viewDidLoad()

		resistorBackgroundView.contentMode = .ScaleAspectFit
		updateUI()
		if !debug {
			resistorBackgroundView.backgroundColor = nil
			containerView.backgroundColor = nil
			[space0, space01, space12, space23, space34, space45].forEach { $0.hidden = true }
			[
				band0IncrementButton, band0DecrementButton,
				band1IncrementButton, band1DecrementButton,
				band2IncrementButton, band2DecrementButton,
				band3IncrementButton, band3DecrementButton,
				band4IncrementButton, band4DecrementButton,
				band5IncrementButton, band5DecrementButton
			].forEach { $0.backgroundColor = nil }
			valueLabel.backgroundColor = nil
		}
		Settings.listenForChanges(self, selector: #selector(defaultsChanged))
		if #available(iOS 9.0, *) {
		} else { // iOS < 9.0
			if rightToLeftTextDirection {
				resistorBackgroundView.transform = CGAffineTransformMakeScale(-1, 1)
			} else { // left-to-right or other
				resistorBackgroundView.transform = CGAffineTransformIdentity
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// **********************

	func incrementPastClear<T: Hashable>(value: T) -> T {
		let newValue = increment(value)
		if newValue == enumValues(T)[0] {
			return increment(newValue)
		}
		return newValue
	}

	func decrementPastClear<T: Hashable>(value: T) -> T {
		let newValue = decrement(value)
		if newValue == enumValues(T)[0] {
			return decrement(newValue)
		}
		return newValue
	}

	@IBAction func band0IncrementPressed(sender: UIButton) {
		rawBand0 = incrementPastClear(rawBand0)
	}
	@IBAction func band0DecrementPressed(sender: UIButton) {
		rawBand0 = decrementPastClear(rawBand0)
	}
	@IBAction func band1IncrementPressed(sender: UIButton) {
		rawBand1 = incrementPastClear(rawBand1)
	}
	@IBAction func band1DecrementPressed(sender: UIButton) {
		rawBand1 = decrementPastClear(rawBand1)
	}
	@IBAction func band2IncrementPressed(sender: UIButton) {
		if bandCount >= 5 {
			valueBand2 = incrementPastClear(valueBand2)
		} else {
			exponentBand2 = incrementPastClear(exponentBand2)
		}
	}
	@IBAction func band2DecrementPressed(sender: UIButton) {
		if bandCount >= 5 {
			valueBand2 = decrementPastClear(valueBand2)
		} else {
			exponentBand2 = decrementPastClear(exponentBand2)
		}
	}
	@IBAction func band3IncrementPressed(sender: UIButton) {
		rawBand3 = incrementPastClear(rawBand3)
	}
	@IBAction func band3DecrementPressed(sender: UIButton) {
		rawBand3 = decrementPastClear(rawBand3)
	}
	@IBAction func band4IncrementPressed(sender: UIButton) {
		rawBand4 = incrementPastClear(rawBand4)
	}
	@IBAction func band4DecrementPressed(sender: UIButton) {
		rawBand4 = decrementPastClear(rawBand4)
	}
	@IBAction func band5IncrementPressed(sender: UIButton) {
		rawBand5 = incrementPastClear(rawBand5)
	}
	@IBAction func band5DecrementPressed(sender: UIButton) {
		rawBand5 = decrementPastClear(rawBand5)
	}

	@IBAction func valueLabelButtonPressed(sender: UIButton) {
		valueFormat = increment(valueFormat)
	}


	@IBAction func segmentsSegmentChanged(sender: UISegmentedControl) {
		let idx = segmentsSegment.selectedSegmentIndex
		// 0 .. 4 -> 1, 3 .. 6
		bandCount = (idx == 0) ? 1 : idx + (-1 + 3)
	}

	// **********************

	private enum ValueFormat {
		case Canonical
		case Scientific
		case Range
	}

	// **********************

	// 1 band:      |
	// 3 bands: | | |
	// 4 bands: | | |   |
	// 5 bands: | | | | |
	// 6 bands: | | | | | |
	private func updateUI() {
		segmentsSegment.selectedSegmentIndex = bandCountAsSelectedSegmentIndex
		let firstThreeBands = bandCount >= 3
		band0DecrementButton.enabled = firstThreeBands
		band0IncrementButton.enabled = firstThreeBands
		band1DecrementButton.enabled = firstThreeBands
		band1IncrementButton.enabled = firstThreeBands
		band2DecrementButton.enabled = firstThreeBands
		band2IncrementButton.enabled = firstThreeBands
		let fourthBand = bandCount >= 5
		band3DecrementButton.enabled = fourthBand
		band3IncrementButton.enabled = fourthBand
		let fifthBand = bandCount >= 4
		band4DecrementButton.enabled = fifthBand
		band4IncrementButton.enabled = fifthBand
		let sixthBand = bandCount == 6
		band5DecrementButton.enabled = sixthBand
		band5IncrementButton.enabled = sixthBand
		updateImageView()
		valueLabel.text = valueString
	}

	private lazy var rightToLeftTextDirection = UIApplication.sharedApplication().userInterfaceLayoutDirection == .RightToLeft

	private func updateImageView() {
		if #available(iOS 9.0, *) {
			resistorBackgroundView.image = composite.imageFlippedForRightToLeftLayoutDirection()
		} else {
			resistorBackgroundView.image = composite
		}
	}

	@objc private func defaultsChanged() {
		updateUI()
	}

	private var rawBand0: ValueBand0 {
		get {
			return ValueBand0(rawValue: Settings.band0RawValue)!
		}
		set {
			Settings.band0RawValue = newValue.rawValue
			updateUI()
		}
	}
	private var rawBand1: ValueBand1 {
		get {
			return ValueBand1(rawValue: Settings.band1RawValue)!
		}
		set {
			Settings.band1RawValue = newValue.rawValue
			updateUI()
		}
	}
	private var valueBand2: ValueBand2 {
		get {
			return ValueBand2(rawValue: Settings.valueBand2RawValue)!
		}
		set {
			Settings.valueBand2RawValue = newValue.rawValue
			updateUI()
		}
	}
	private var exponentBand2: ExponentBand2 {
		get {
			return ExponentBand2(rawValue: Settings.exponentBandRawValue)!
		}
		set {
			Settings.exponentBandRawValue = newValue.rawValue
			updateUI()
		}
	}
	private var rawBand3: AlternateExponentBand3 {
		get {
			return AlternateExponentBand3(rawValue: Settings.exponentBandRawValue)!
		}
		set {
			Settings.exponentBandRawValue = newValue.rawValue
			updateUI()
		}
	}

	private var rawBand4: ToleranceBand4 {
		get {
			return ToleranceBand4(rawValue: Settings.band4RawValue)!

		}
		set {
			Settings.band4RawValue = newValue.rawValue
			updateUI()
		}
	}

	private var rawBand5: TemperatureCoefficientBand5 {
		get {
			return TemperatureCoefficientBand5(rawValue: Settings.band5RawValue)!
		}
		set {
			Settings.band5RawValue = newValue.rawValue
			updateUI()
		}
	}


	private let sprite: UIImage = UIImage.init(named: "sprite")!

	// d = digit, e = exponent, t = tolerance, c = temp co.
	//          0 1 2 3 4 5
	// 1 band:      d
	// 3 bands: d d e
	// 4 bands: d d e   t
	// 5 bands: d d d e t
	// 6 bands: d d d e t c
	// draw band 6 before 5 because of clipping

	private var band0: ValueBand0 {
		return (bandCount != 1) ? rawBand0 : .Clear
	}

	private var band1: ValueBand1 {
		return (bandCount != 1) ? rawBand1 : .Clear
	}

	private var band2: Band {
		if bandCount == 1 {
			return ValueBand2.Black
		} else if bandCount >= 5 {
			return valueBand2
		}
		// bandCount == 3 or 4
		return exponentBand2
	}

	private var band3: AlternateExponentBand3 {
		return (bandCount >= 5) ? rawBand3 : .Clear
	}

	private var band4: ToleranceBand4 {
		return (bandCount >= 4) ? rawBand4 : .Clear
	}

	private var band5: TemperatureCoefficientBand5 {
		return (bandCount == 6) ? rawBand5 : .Clear
	}

	private var bandSprites: [(UIImage, CGPoint)] {
		return [band0, band1, band2, band3, band5, band4].map {
			(sprite.clip($0.spriteSourceRect), $0.bkgndDestRect.origin)
		}
	}

	private var mantissa: Double {
		if bandCount == 1 { // for 0 ohm resistor
			return 0.0
		}
		let result = 10.0 * band0.value + 1.0 * band1.value
		if bandCount >= 5 {
			return 10.0 * result + valueBand2.value
		}
		return result
	}

	private var exponent: Double {
		if bandCount == 1 { // for 0 ohm resistor
			return 1.0
		}
		return (bandCount >= 5) ? band3.exponent : exponentBand2.exponent
	}

	private var value: Double { return mantissa * pow(10.0, exponent) }

	private var percent: Double { return band4.percent }

	private var valueFormat: ValueFormat = .Canonical { didSet { updateUI() } }

	private var valueString: String {
		let s: [String] = rightToLeftTextDirection ? valueStrings.reverse() : valueStrings
		return s.joinWithSeparator(" ")
	}

	private var valueStrings: [String] {
		switch valueFormat {
		case .Canonical: return valueStringsCanonical
		case .Scientific: return valueStringsScientific
		case .Range: return valueStringsRange
		}
	}

	private let allOhmUnitsUnlocalized: [(Double, String)] = [
		(1_000_000_000.0,   "1e9"),
		(    1_000_000.0,   "1e6"),
		(        1_000.0,   "1e3"),
		(            1.0,   "1e0"),
		(            0.001, "1e-3"),
		(            0.0,   "1e0")
	]

	private func ohmsInUnits(v: Double) -> (Double, String) {
		for (base, unitsLocalizedKey) in allOhmUnitsUnlocalized {
			if v >= base {
				return (v / (base == 0 ? 1.0 : base), NSLocalizedString(unitsLocalizedKey, comment: ""))
			}
		}
		return (v, "")
	}

	private var bandCountAsSelectedSegmentIndex: Int {
		return (bandCount == 1) ? 0 : (bandCount-2)
	}

	// d = digit, e = exponent, t = tolerance, c = temp co.
	// 3 bands: d d e
	// 4 bands: d d e   t
	// 5 bands: d d d e t
	// 6 bands: d d d e t c
	private var bandCount: Int {
		get {
			return Settings.bandCount
		}

		set {
			if bandCount == newValue { // nothing to do
				return
			}

			if bandCount <= 4 && newValue >= 5 { // 3,4 -> 5,6
				rawBand3 = AlternateExponentBand3(rawValue: exponentBand2.rawValue)!
			} else if bandCount >= 5 && newValue <= 4 { // 5,6 -> 4,3
				exponentBand2 = ExponentBand2(rawValue: band3.rawValue)!
			}
			Settings.bandCount = newValue
			updateUI()
		}
	}

	private var normalizedMantissa: Double {
		return (bandCount >= 5) ? mantissa : 10.0 * mantissa
	}

	private var eiaSeriesString: [String] {
		if let eia = EIAClass.classify(EIAClass.Mantissa(normalizedMantissa), tolerance: band4.tolerance) {
			return [eia.description]
		}
		return []
	}

	private var temperatureCoefficient: Int {
		return band5.rawValue
	}

	private var temperatureCoefficientString: [String] {
		if bandCount < 6 {
			return []
		}

		let fmt = Settings.nsNumberFormatterFactory()
		fmt.maximumFractionDigits = 0
		return [fmt.stringFromNumber(temperatureCoefficient)!, "ppm/ºC"]
	}

	private var percentString: String {
		let fmt = Settings.nsNumberFormatterFactory()
		fmt.maximumFractionDigits = 2
		fmt.numberStyle = .PercentStyle
		let pcntStr = fmt.stringFromNumber(percent)!
		return pcntStr
	}

	private var valueStringsCanonical: [String] {
		let fmt = Settings.nsNumberFormatterFactory()
		fmt.maximumFractionDigits = (bandCount >= 5) ? 2 : 1

		let oInUnits = ohmsInUnits(value)
		let ohms: String = fmt.stringFromNumber(oInUnits.0)!
		let units: String = oInUnits.1

		let result = [ohms, units]
		if value == 0.0 {
			return result
		}
		return result + ["±", percentString] + eiaSeriesString + temperatureCoefficientString
	}


	private var valueStringsScientific: [String] {
		let fmt = Settings.nsNumberFormatterFactory()
		if bandCount >= 5 { // 5,6 bands, 3 digit mantissa
			if mantissa >= 10.0 {
				fmt.maximumFractionDigits = 1
			} else if mantissa >= 1.0 {
				fmt.maximumFractionDigits = 2
			} else if mantissa >= 0.1 {
				fmt.maximumFractionDigits = 3
			} else {
				fmt.maximumFractionDigits = 0
			}
		} else { // 3,4 bands, 2 digit mantissa
			if mantissa >= 1.0 {
				fmt.maximumFractionDigits = 1
			} else if mantissa >= 0.1 {
				fmt.maximumFractionDigits = 2
			} else {
				fmt.maximumFractionDigits = 0
			}
		}
		fmt.numberStyle = .ScientificStyle

		let ohmsScientific = fmt.stringFromNumber(value)!

		let result = [ohmsScientific, NSLocalizedString("1e0", comment: "")]
		if value == 0.0 {
			return result
		}
		return result + ["±", percentString] + eiaSeriesString + temperatureCoefficientString
	}

	private var valueStringsRange: [String] {
		let fmt = Settings.nsNumberFormatterFactory()
		fmt.maximumFractionDigits = (bandCount >= 5) ? 2 : 1

		let lower = value * (1.0 - percent)
		let upper = value * (1.0 + percent)
		let lowerInUnits = ohmsInUnits(lower)
		let upperInUnits = ohmsInUnits(upper)
		let lowerOhms: String = fmt.stringFromNumber(lowerInUnits.0)!
		let lowerUnits: String = lowerInUnits.1
		let upperOhms: String = fmt.stringFromNumber(upperInUnits.0)!
		let upperUnits: String = upperInUnits.1


		let result = [lowerOhms, lowerUnits, "-", upperOhms, upperUnits]

		if value == 0.0 {
			return result
		}
		return result + [percentString] + eiaSeriesString + temperatureCoefficientString
	}

	private lazy var background: UIImage = self.sprite.clip(CGRectMake(400, 0, 400, 200))
	private var composite: UIImage { return background.mergeMany(bandSprites) }
}

