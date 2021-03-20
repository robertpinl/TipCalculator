//
//  TipButton.swift
//  TipCalculator
//
//  Created by Robert P on 20.03.2021.
//

import UIKit

class TipButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor(named: "brandBlueColor")?.cgColor
                backgroundColor = .tertiarySystemBackground
                tintColor = .clear
            } else {
                backgroundColor = UIColor(named: "brandBlueColor")
                tintColor = UIColor(named: "fontColor")
                tintColor = .clear
            }
        }
    }
}

