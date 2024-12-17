//
//  ViewController.swift
//  Homework-2-4-Colors
//
//  Created by Алексей Журкин on 29.11.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet weak var outRGBView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSliders(from: mainColor)
        setupLabels()
        setupOutRGB()
        setOutRGB()
    }
    
    // MARK: IB Actions
    @IBAction func redSliderMoved() {
        setLabelValue(for: redLabel, from: redSlider)
        setOutRGB()
    }
    
    @IBAction func greenSliderMoved() {
        setLabelValue(for: greenLabel, from: greenSlider)
        setOutRGB()
    }
    
    @IBAction func blueSliderMoved() {
        setLabelValue(for: blueLabel, from: blueSlider)
        setOutRGB()
    }
    @IBAction func doneButtonAction() {
        if let rgbColor = outRGBView.backgroundColor {
            delegate?.didSelectColor(rgbColor)
        }
        dismiss(animated: true)
    }
    
    // MARK: Private methods
    private func setLabelValue (for label: UILabel, from slider: UISlider) {
//        label.text = (round(slider.value * 100) / 100).formatted()
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func setOutRGB() {
        outRGBView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// MARK: UI Initialisation
extension SettingsViewController {
    private func setupOutRGB() {
        outRGBView.layer.cornerRadius = 10
        outRGBView.layer.borderWidth = 2
        outRGBView.layer.borderColor = .init(
            red: 0,
            green: 0,
            blue: 0,
            alpha: 0.3
        )
    }
    
    private func setupSliders(from mainColor: UIColor) {
        var colorRed: CGFloat = 0
        var colorGreen: CGFloat = 0
        var colorBlue: CGFloat = 0
        var colorAlpha: CGFloat = 0
        
        if mainColor.getRed(&colorRed, green: &colorGreen, blue: &colorBlue, alpha: &colorAlpha) {
            redSlider.value = Float(colorRed)
            greenSlider.value = Float(colorGreen)
            blueSlider.value = Float(colorBlue)
        } else {
            redSlider.value = 1
            greenSlider.value = 1
            blueSlider.value = 1
        }
    }
    
    private func setupLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}
