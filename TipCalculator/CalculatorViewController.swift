//
//  CalculatorViewController.swift
//  TipCalculator
//
//  Created by Robert Pinl on 06.02.2021.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var fifteenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var totalAmount: Double = 0
    var tip: Double = 0
    var split: Double = 2
    var totalTip: Double = 0
    var totalBill: Double = 0
    var totalPerPerson: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tenButton.layer.cornerRadius = 12
        fifteenButton.layer.cornerRadius = 12
        twentyButton.layer.cornerRadius = 12
        calculateButton.layer.cornerRadius = 12
        minusButton.layer.cornerRadius = 12
        plusButton.layer.cornerRadius = 12
        
    }
    
    @IBAction func tipPressed(_ sender: UIButton) {
        
        amountTextField.endEditing(true)
        
        tenButton.isSelected = false
        fifteenButton.isSelected = false
        twentyButton.isSelected = false
        sender.isSelected = true
        
        
        if sender.tag == 0 {
            tip = 10
        } else if sender.tag == 1 {
            tip = 15
        } else {
            tip = 20
        }
    }
    
    @IBAction func splitPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            split += 1
        } else {
            split -= 1
        }
        
        splitLabel.text = String(format: "%0.f", split)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = amountTextField.text!
        
        if bill != "" {
            totalAmount = Double(bill) ?? 0
            totalTip = (totalAmount / 100) * tip
            totalBill = totalAmount + totalTip
            totalPerPerson = totalBill / split
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.totalTip = totalTip
        destinationVC.totalBill = totalBill
        destinationVC.totalPerPerson = totalPerPerson
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        if string == "," {
                   textField.text = textField.text! + "."
                   return false
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        let substringToReplace = oldText[r]
        let numberOfCharacters = oldText.count - substringToReplace.count + string.count
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2 && numberOfCharacters <= 8
    }
}

