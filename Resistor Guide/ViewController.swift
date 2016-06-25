//
//  ViewController.swift
//  Resistor Guide
//
//  Created by Bad Motherfucker on 6/20/16.
//  Copyright © 2016 BMF. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

	let debug = false

	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var resistorBackgroundView: UIImageView!
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var valueLabelButton: UIButton!
	@IBOutlet weak var space0: UIView!
	@IBOutlet weak var band0Button: UIButton!
	@IBOutlet weak var space01: UIView!
	@IBOutlet weak var band1Button: UIButton!
	@IBOutlet weak var space12: UIView!
	@IBOutlet weak var band2Button: UIButton!
	@IBOutlet weak var space23: UIView!
	@IBOutlet weak var band3Button: UIButton!
	@IBOutlet weak var space34: UIView!
	@IBOutlet weak var band4Button: UIButton!

	// **********************

	override func viewDidLoad() {
		super.viewDidLoad()
		resistorBackgroundView.contentMode = .ScaleAspectFit
		updateUI()
		if (!debug) {
			resistorBackgroundView.backgroundColor = nil
			containerView.backgroundColor = nil
			[space0, space01, space12, space23, space34].forEach { $0.hidden = true }
			[band0Button, band1Button, band2Button, band3Button, band4Button].forEach { $0.backgroundColor = nil }
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// **********************

	@IBAction func band0UpperPressed(sender: UIButton) {
		band0 = increment(band0)
	}
	@IBAction func band0LowerPressed(sender: UIButton) {
		band0 = decrement(band0)
	}
	@IBAction func band1UpperPressed(sender: UIButton) {
		band1 = increment(band1)
	}
	@IBAction func band1LowerPressed(sender: UIButton) {
		band1 = decrement(band1)
	}
	@IBAction func band2UpperPressed(sender: UIButton) {
		if (fiveDigits) {
			valueBand2 = increment(valueBand2)
		} else {
			exponentBand2 = increment(exponentBand2)
		}
	}
	@IBAction func band2LowerPressed(sender: UIButton) {
		if (fiveDigits) {
			valueBand2 = decrement(valueBand2)
		} else {
			exponentBand2 = decrement(exponentBand2)
		}
	}
	@IBAction func band3UpperPressed(sender: UIButton) {
		band3 = increment(band3)
	}
	@IBAction func band3LowerPressed(sender: UIButton) {
		band3 = decrement(band3)
	}
	@IBAction func band4UpperPressed(sender: UIButton) {
		band4 = increment(band4)
	}
	@IBAction func band4LowerPressed(sender: UIButton) {
		band4 = decrement(band4)
	}

	@IBAction func valueLabelButtonPressed(sender: UIButton) {
		valueFormat = increment(valueFormat)
	}
	

	// **********************

	private enum ValueFormat {
		case Canonical
		case Scientific
	}

	// **********************

	private func updateUI() {
		updateImageView()
		updateOhmsLabel()
	}

	private func updateOhmsLabel() {
		valueLabel.text = valueString
	}

	private func updateImageView() {
		resistorBackgroundView.image = composite
	}

	private var band0: ValueBand0 = .Brown { didSet { updateUI() } }
	private var band1: ValueBand1 = .Black { didSet { updateUI() } }
	private var valueBand2: ValueBand2 = .Black { didSet { updateUI() } }
	private var exponentBand2: ExponentBand2 = .Black { didSet { updateUI() } }
	private var band3: AlternateExponentBand3 = .Red { didSet { updateUI() } }
	private var band4: ToleranceBand4 = .Black { didSet { updateUI() } }

	private let sprite: UIImage = UIImage.init(named: "sprite")!

	private var fiveBands: Bool = true

	private var bandSprites: [(UIImage, CGPoint)] {
		let bands: [Band] = [band0, band1, ((fiveDigits) ? valueBand2 : exponentBand2), band3, band4]
		return bands.map { (sprite.clip($0.spriteSourceRect), $0.bkgndDestRect.origin) }
	}

	private var mantissa: Double {
		var result: Double =
			   10.0 * band0.value
			  + 1.0 * band1.value

		if (fiveBands) {
			result = 10.0 * result + valueBand2.value
		}

		print("mantissa: ", result)

		return result
	}

	private var exponent: Double {
		var result: Double
		if fiveBands {
			result = band3.exponent
		} else {
			result = exponentBand2.exponent
		}
		print("exponent: ", result)
		return result
	}

	private var value: Double { return mantissa * pow(10.0, exponent) }

	private var percent: Double { return band4.percent }

	private var valueFormat: ValueFormat = .Canonical {
		didSet { updateUI() }
	}
	private var valueString: String {
		switch valueFormat {
		case .Canonical: return valueStringCanonical
		case .Scientific: return valueStringScientific
		}
	}

	private let allOhmUnitsUnlocalized = [
		(1_000_000_000.0,   "1e9"),
		(    1_000_000.0,   "1e6"),
		(        1_000.0,   "1e3"),
		(            1.0,   "1e0"),
		(            0.001, "1e-3"),
		(            0.0,   "1e0")
	]

	private var ohmsInUnits: (Double, String) {
		let v = value
		for (base, unitsLocalizedKey) in allOhmUnitsUnlocalized {
			if v >= base {
				return (v / (base == 0 ? 1.0 : base), NSLocalizedString(unitsLocalizedKey, comment: ""))
			}
		}
		return (v, "")
	}

	private var fiveDigits: Bool = true {
		willSet {
			if fiveDigits == newValue {
				return
			}
			if (newValue) { // 4 -> 5
				band3 = AlternateExponentBand3(rawValue: exponentBand2.rawValue)!
			} else { // 5 -> 4
				exponentBand2 = ExponentBand2(rawValue: band3.rawValue)!
			}
		}
		didSet {
			updateUI()
		}
	}

	private var eiaSeriesString: String {
		switch EIAClass.classify(EIAClass.Mantissa(mantissa), tolerance: band4.tolerance) {
		case .None: return ""
		case .E3: return "E3"
		case .E6: return "E6"
		case .E12: return "E12"
		case .E24: return "E24"
		case .E48: return "E48"
		case .E96: return "E96"
		case .E192: return "E192"
		}
	}

	private var percentString: String {
		let fmt = NSNumberFormatter()
		fmt.minimumIntegerDigits = 1
		fmt.maximumFractionDigits = 2
		return fmt.stringFromNumber(percent)!
	}

	private var valueStringCanonical: String {
		let fmt = NSNumberFormatter()
		fmt.minimumIntegerDigits = 1
		fmt.maximumFractionDigits = (fiveDigits) ? 2 : 1

		let oInUnits = ohmsInUnits
		let ohms: String = fmt.stringFromNumber(oInUnits.0)!
		let units: String = oInUnits.1

		return ohms + " " + units + "Ω ± " + percentString + "%" + " " + eiaSeriesString
	}


	private var valueStringScientific: String {
		let fmt = NSNumberFormatter()
		fmt.minimumIntegerDigits = 1
		fmt.maximumFractionDigits = (fiveDigits) ? 2 : 1
		fmt.numberStyle = .ScientificStyle

		let ohmsScientific = fmt.stringFromNumber(value)!

		return ohmsScientific + "Ω ± " + percentString + "%" + " " + eiaSeriesString
	}

	private lazy var background: UIImage = self.sprite.clip(CGRectMake(400, 0, 400, 200))
	private var composite: UIImage { return background.mergeMany(bandSprites) }

}

