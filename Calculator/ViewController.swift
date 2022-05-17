//
//  ViewController.swift
//  Calculator
//
//  Created by Кирилл Тараско on 15.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        guard let number = sender.currentTitle else { return }
        
        if stillTyping {
            if displayResultLabel.text?.count ?? 0 < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        
        stillTyping = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func equalityButtonPressed(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            if secondOperand != 0 {
                operateWithTwoOperands{$0 / $1}
            } else {
                return
            }
        default: break
            
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
}

