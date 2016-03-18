//
//  OhmCalcViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/3/17.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class OhmCalcViewController: UIViewController {
    
    @IBOutlet weak var batteryMVText: UITextField!
    @IBOutlet weak var ohmPermVText: UITextField!
    @IBOutlet weak var hopeOhmText: UITextField!
    @IBOutlet weak var diameterText: UITextField!
    @IBOutlet weak var powerText: UITextField!
    @IBOutlet weak var lengthText: UITextField!
    @IBOutlet weak var trunsText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.layer.contents = UIImage(named: "background")!.CGImage
        
        self.calc()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close() {
        self.batteryMVText.resignFirstResponder()
        self.ohmPermVText.resignFirstResponder()
        self.hopeOhmText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func calc() {
        self.batteryMVText.resignFirstResponder()
        self.ohmPermVText.resignFirstResponder()
        self.hopeOhmText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        if (self.batteryMVText.text != "" && self.ohmPermVText.text != "" && self.hopeOhmText.text != "" && self.diameterText.text != "") {
            
            let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 5, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            
            let batteryvdec: NSDecimalNumber = NSDecimalNumber(string: self.batteryMVText.text)
            let ohmpermvdec: NSDecimalNumber = NSDecimalNumber(string: self.ohmPermVText.text)
            let hopeOhmdec: NSDecimalNumber = NSDecimalNumber(string: self.hopeOhmText.text)
            let diameterdec: NSDecimalNumber = NSDecimalNumber(string: self.diameterText.text)
            
            let powerdec: NSDecimalNumber = batteryvdec.decimalNumberByMultiplyingBy(batteryvdec).decimalNumberByDividingBy(hopeOhmdec)
            let lengthdec: NSDecimalNumber = hopeOhmdec.decimalNumberByDividingBy(ohmpermvdec.decimalNumberByDividingBy(NSDecimalNumber(string: "100")))
            let truns: NSDecimalNumber = lengthdec.decimalNumberByDividingBy(NSDecimalNumber(string: "3.14").decimalNumberByMultiplyingBy(diameterdec).decimalNumberByDividingBy(NSDecimalNumber(string: "10")))
            
            self.powerText.text = powerdec.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
            self.lengthText.text = lengthdec.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
            self.trunsText.text = truns.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
        }
    }
}
