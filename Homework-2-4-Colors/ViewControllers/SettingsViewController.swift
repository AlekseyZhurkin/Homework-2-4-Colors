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
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setupSliders(from: mainColor)
        setupLabels()
        setupTextFields()
        setupOutRGB()
        setOutRGB()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: IB Actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setLabelValue(for: redLabel, from: redSlider)
            setTextFieldValue(for: redTextField, from: redSlider)
        case greenSlider:
            setLabelValue(for: greenLabel, from: greenSlider)
            setTextFieldValue(for: greenTextField, from: greenSlider)
        default:
            setLabelValue(for: blueLabel, from: blueSlider)
            setTextFieldValue(for: blueTextField, from: blueSlider)
        }
        
        setOutRGB()
    }
    
    
    @IBAction func doneButtonAction() {
        if let rgbColor = outRGBView.backgroundColor {
            delegate?.didSelectColor(rgbColor)
        }
        dismiss(animated: true)
    }
    
    // MARK: Private methods
    private func setLabelValue(for label: UILabel, from slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func setTextFieldValue(for textField: UITextField, from slider: UISlider) {
        textField.text = String(format: "%.2f", slider.value)
    }
    
    private func setOutRGB() {
        outRGBView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: UI Initialisation
extension SettingsViewController {
    private func setupOutRGB() {
        outRGBView.layer.cornerRadius = 10
        outRGBView.layer.borderWidth = 2
        outRGBView.layer.borderColor = CGColor.init(
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
    
    private func setupTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupSlider(_ textField: UITextField) {
        guard let valueTextField = textField.text else { return }
        
        guard let valueText = Float(normText(from: valueTextField)) else { return }
        
        switch textField {
        case redTextField:
            redSlider.setValue(valueText, animated: true)
        case greenTextField:
            greenSlider.setValue(valueText, animated: true)
        default:
            blueSlider.setValue(valueText, animated: true)
        }
    }
    
    private func normText(from inputText: String) -> String {
        return inputText.replacingOccurrences(of: ",", with: ".")
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputText = textField.text else {
            showAlert(
                withTitle: "Wrong format",
                andMessage: "Please, enter correct value"
            ) {
                textField.text = "0.50"
                self.setupSlider(textField)
                self.setupLabels()
                self.setupTextFields()
                self.setOutRGB()
            }
            
            return
        }
        
        let inputTextNormalize = normText(from: inputText)
        
        guard let textFieldValue = Float(inputTextNormalize), (0...1).contains(textFieldValue) else {
            showAlert(
                withTitle: "Wrong format",
                andMessage: "Please, enter correct value"
            ) {
                textField.text = "0.50"
                self.setupSlider(textField)
                self.setupLabels()
                self.setupTextFields()
                self.setOutRGB()
            }
            
            return
        }

        setupSlider(textField)
        setupLabels()
        setupTextFields()
        setOutRGB()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addDoneButtonToKeyboard(textField)
    }
    func addDoneButtonToKeyboard(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolbar.items = [flexibleSpace, doneButton]

        textField.inputAccessoryView = toolbar
    }
}
