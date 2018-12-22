//
//  ViewController.swift
//  Tip App
//
//  Created by Kevin Chen on 12/15/2018.
//  Copyright © 2018 Kevin Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var splitControl: UIStepper!
    @IBOutlet weak var splitNum: UILabel!
    @IBOutlet weak var splitEach: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.billField.becomeFirstResponder()
        
        let filename = "Test"
        let DocumentDirUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirUrl.appendingPathComponent(filename).appendingPathExtension("txt")
        
        print("File Path: \(fileURL.path)")
        
        let writeString = "write this text to the file in Swift"
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to write to URL")
            print(error)
        }
        
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
        
        print("Contents of the file \(readString)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.15, 0.2, 0.40]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"$%.2f", total)
        
        splitNum.text = String(Int(splitControl.value))
        splitEach.text = String(format:"$%.2f", total / splitControl.value)
    }
    
}

