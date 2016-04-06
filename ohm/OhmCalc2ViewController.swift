//
//  OhmCalc2ViewController.swift
//  ohm
//
//  Created by 刘 朝仁 on 16/3/18.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

import UIKit

class OhmCalc2ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var materialBtn: UIButton! //发热丝分类
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var pickerviewtoolbar: UIToolbar!
    @IBOutlet weak var materialOhms: UILabel! //发热丝电阻率
    @IBOutlet weak var batteryVText: UITextField! //电池电压
    @IBOutlet weak var batteryVBtn: UIStepper! //电压加减
    @IBOutlet weak var diameterText: UITextField! //发热丝直径
    @IBOutlet weak var boreText: UITextField! //线圈内径
    @IBOutlet weak var turns: UILabel! //圈数
    @IBOutlet weak var turnsBtn: UIStepper! //圈数加减
    @IBOutlet weak var parallel: UISegmentedControl! //并联数
    @IBOutlet weak var ohms: UILabel! //电阻值
    @IBOutlet weak var power: UILabel! //电功率
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.layer.contents = UIImage(named: "background")!.CGImage
        
        self.view.bringSubviewToFront(self.pickerview)
        self.view.bringSubviewToFront(self.pickerviewtoolbar)
        
        pickerViewFinish()
        
        calc()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func powerEditEnd() {
        self.pickerviewtoolbar.hidden = true
        if self.batteryVText.text == "" {
            return
        }
        
        let batteryVstr: NSString = NSString(string: self.batteryVText.text!)
        if batteryVstr.doubleValue > 4.2 {
            self.batteryVText.text = "4.2"
            self.batteryVBtn.value = 4.2
        } else {
            self.batteryVBtn.value = batteryVstr.doubleValue
        }
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let dec: NSDecimalNumber = NSDecimalNumber(double: self.batteryVBtn.value)
        self.batteryVText.text = dec.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
        calcPower()
    }
    
    @IBAction func editEnd() {
        self.pickerviewtoolbar.hidden = true
        calc()
    }
    
    @IBAction func showFinish() {
        self.pickerviewtoolbar.hidden = false
        self.view.bringSubviewToFront(self.pickerviewtoolbar)
    }
    
    @IBAction func calc() {
        self.batteryVText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.boreText.resignFirstResponder()
        if self.batteryVText.text == "" || self.diameterText.text == "" || self.boreText.text == "" {
            return
        }
        
        let n: NSDecimalNumber = NSDecimalNumber(string: self.turns.text)
        let d: NSDecimalNumber = NSDecimalNumber(string: self.diameterText.text)
        let D1: NSDecimalNumber = NSDecimalNumber(string: self.boreText.text)
        let p: NSDecimalNumber = NSDecimalNumber(string: self.materialOhms.text)
        let paralleldec: NSDecimalNumber = NSDecimalNumber(int: (self.parallel.selectedSegmentIndex + 1))
        let batteryVdec: NSDecimalNumber = NSDecimalNumber(string: self.batteryVText.text)
        let R = calcR(p, n: n, d: d, D1: D1, parallel: paralleldec)
        let powerdec = calcP(batteryVdec, R: R)
        
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        Rdec = R.decimalNumberByRoundingAccordingToBehavior(rounding)
        Pdec = powerdec.decimalNumberByRoundingAccordingToBehavior(rounding)
        
        Rdecinit = NSDecimalNumber(string: "0")
        Pdecinit = NSDecimalNumber(string: "0")

        NSTimer.scheduledTimerWithTimeInterval(ti / times, target: self, selector:#selector(OhmCalc2ViewController.numberToR(_:)),userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(ti / times, target: self, selector:#selector(OhmCalc2ViewController.numberToP(_:)),userInfo: nil, repeats: true)
    }
    
    @IBAction func calcPower() {
        self.batteryVText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.boreText.resignFirstResponder()
        if self.batteryVText.text == "" || self.diameterText.text == "" || self.boreText.text == "" {
            return
        }
        
        let n: NSDecimalNumber = NSDecimalNumber(string: self.turns.text)
        let d: NSDecimalNumber = NSDecimalNumber(string: self.diameterText.text)
        let D1: NSDecimalNumber = NSDecimalNumber(string: self.boreText.text)
        let p: NSDecimalNumber = NSDecimalNumber(string: self.materialOhms.text)
        let paralleldec: NSDecimalNumber = NSDecimalNumber(int: (self.parallel.selectedSegmentIndex + 1))
        let batteryVdec: NSDecimalNumber = NSDecimalNumber(string: self.batteryVText.text)
        let R = calcR(p, n: n, d: d, D1: D1, parallel: paralleldec)
        let powerdec = calcP(batteryVdec, R: R)
        
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        Rdec = R.decimalNumberByRoundingAccordingToBehavior(rounding)
        Pdec = powerdec.decimalNumberByRoundingAccordingToBehavior(rounding)
        
        Rdecinit = NSDecimalNumber(string: "0")
        Pdecinit = NSDecimalNumber(string: "0")

        NSTimer.scheduledTimerWithTimeInterval(ti / times, target: self, selector:#selector(OhmCalc2ViewController.numberToP(_:)),userInfo: nil, repeats: true)
    }
    
    let ti: NSTimeInterval = 0.1
    let times: Double = 5.0
    var Rdecinit: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Pdecinit: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Rdec: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Pdec: NSDecimalNumber = NSDecimalNumber(string: "0")
    
    func numberToR(tUpdate:NSTimer) {
        Rdecinit = Rdecinit.decimalNumberByAdding(Rdec.decimalNumberByDividingBy(NSDecimalNumber(double: times)))
        self.ohms.text = Rdecinit.stringValue
        if (Rdecinit.compare(Rdec) == .OrderedDescending) {
            tUpdate.invalidate()
            self.ohms.text = Rdec.stringValue
        }
    }
    
    func numberToP(tUpdate:NSTimer) {
        Pdecinit = Pdecinit.decimalNumberByAdding(Pdec.decimalNumberByDividingBy(NSDecimalNumber(double: times)))
        self.power.text = Pdecinit.stringValue
        if (Pdecinit.compare(Pdec) == .OrderedDescending) {
            tUpdate.invalidate()
            self.power.text = Pdec.stringValue
        }
    }
    
    @IBAction func batteryVChange() {
        self.pickerviewtoolbar.hidden = true
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let dec: NSDecimalNumber = NSDecimalNumber(double: self.batteryVBtn.value)
        self.batteryVText.text = dec.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
        calcPower()
    }
    
    @IBAction func turnsChange() {
        self.pickerviewtoolbar.hidden = true
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let dec: NSDecimalNumber = NSDecimalNumber(double: self.turnsBtn.value)
        self.turns.text = dec.decimalNumberByRoundingAccordingToBehavior(rounding).stringValue
        calc()
    }
    
    @IBAction func close() {
        self.batteryVText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.boreText.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func pickerViewDisplay() {
        self.batteryVText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.boreText.resignFirstResponder()
        self.pickerview.hidden = false
        self.pickerviewtoolbar.hidden = false
        self.view.bringSubviewToFront(self.pickerviewtoolbar)
    }
    
    @IBAction func pickerViewFinish() {
        self.batteryVText.resignFirstResponder()
        self.diameterText.resignFirstResponder()
        self.boreText.resignFirstResponder()
        self.pickerview.hidden = true
        self.pickerviewtoolbar.hidden = true
        self.materialBtn.setTitle(pickdata[self.pickerview.selectedRowInComponent(0)].objectForKey("name") as? String, forState: UIControlState.Normal)
        let ohms = pickdata[self.pickerview.selectedRowInComponent(0)].objectForKey("ohm") as? NSDecimalNumber
        self.materialOhms.text = ohms?.stringValue
        calc()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickdata.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickdata[row].objectForKey("name") as? String
    }
    
}
