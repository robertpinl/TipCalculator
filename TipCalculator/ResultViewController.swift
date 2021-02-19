//
//  ResultViewController.swift
//  TipCalculator
//
//  Created by Robert Pinl on 06.02.2021.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    var totalPerPerson: Double = 0
    var totalBill: Double = 0
    var totalTip: Double = 0
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recalculateButton.layer.cornerRadius = 12
        
        totalPerPersonLabel.text = numberFormatter.string(from: NSNumber(value: totalPerPerson))
        totalBillLabel.text = numberFormatter.string(from: NSNumber(value: totalBill))
        totalTipLabel.text = numberFormatter.string(from: NSNumber(value: totalTip))
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
