//
//  ViewController.swift
//  Homework-2-4-Colors
//
//  Created by Алексей Журкин on 29.11.2024.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet weak var outRGBView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSliders()
        setupLabels()
        setupOutRGB()
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
    
    // MARK: Private methods
    private func setLabelValue (for label: UILabel, from slider: UISlider) {
        label.text = (round(slider.value * 100) / 100).formatted()
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
extension ViewController {
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
    
    private func setupSliders() {
        redSlider.value = 1.00
        greenSlider.value = 1.00
        blueSlider.value = 1.00
    }
    
    private func setupLabels() {
        redLabel.text = redSlider.value.formatted()
        greenLabel.text = greenSlider.value.formatted()
        blueLabel.text = blueSlider.value.formatted()
    }
}
