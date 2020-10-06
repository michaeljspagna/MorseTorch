//
//  ViewController.swift
//  MorseTorch
//
//  Created by Michael Spagna on 10/5/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: Properties
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var morseTextView: UITextView!
    
    
    let morseCode = MorseCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpMoresTextView()
        self.setUPInoutTextField()
    }
    
    @IBAction func convertBrn(_ sender: UIButton) {
        let inputText = self.inputTextField.text ?? ""
        let morseArray = morseCode.stringToMorseArray(inputMsg: inputText)
        let morseString = morseCode.morseArrayToMorseString(morseArray: morseArray)
        self.morseTextView.text = morseString
    }
    
    @IBAction func sosBtn(_ sender: UIButton) {
        let sosArray = self.morseCode.SOS
        let sosString = self.morseCode.morseArrayToMorseString(morseArray: sosArray)
        self.morseCode.flashMorseString(morseString: sosString)
    }
    
    @IBAction func flashBtn(_ sender: UIButton) {
        let morseString = self.morseTextView.text ?? ""
        self.morseCode.flashMorseString(morseString: morseString)
    }
    
    func setUpMoresTextView() -> Void{
        self.morseTextView.delegate = self
        self.morseTextView.isEditable = false
        self.morseTextView.backgroundColor = UIColor.white
    }
    
    func setUPInoutTextField() -> Void{
        self.inputTextField.delegate = self
    }
}

