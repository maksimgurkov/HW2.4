//
//  SetupColorViewController.swift
//  HW2.4
//
//  Created by Максим Гурков on 06.02.2023.
//

import UIKit

class SetupColorViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var rGBbView: UIView!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    unowned var delegate: SetupViewProtocol!
    var color: UIColor!
        
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        rGBbView.backgroundColor = color
        rGBbView.layer.cornerRadius = 8
        setSliders()
        setValueLabels(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValueTextFields(for: redTextField, greenTextField, blueTextField)
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IBAction
    @IBAction func rGBSliders(_ sender: UISlider) {
        viewColors()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    
    @IBAction func doneActionButton() {
        delegate.setup(color: rGBbView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}
//MARK: - Extension private Functions
extension SetupColorViewController {
        
    private func viewColors() {
        rGBbView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValueLabels(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = string(from: greenSlider)
            default:
                blueValueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValueTextFields(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func alertController(message: String) {
        let alert = UIAlertController(
            title: "Внимание",
            message: message,
            preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(actionAlert)
        present(alert, animated: true)
    }
    
    private func addDoneButtonTo(_ textField: UITextField) {
        let keyBoardToolBar = UIToolbar()
        textField.inputAccessoryView = keyBoardToolBar
        keyBoardToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil)
        keyBoardToolBar.setItems([flexBarButton, doneButton], animated: false)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate
extension SetupColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        if let numberValue = Float(newValue) {
            switch textField {
            case redTextField:
                redSlider.value = numberValue
                setValueLabels(for: redValueLabel)
            case greenTextField:
                greenSlider.value = numberValue
                setValueLabels(for: redValueLabel)
            default:
                blueSlider.value = numberValue
                setValueLabels(for: blueValueLabel)
            }
            viewColors()
        } else {
            alertController(message: "Не верный формат ввода")
        }
    }
    
}

