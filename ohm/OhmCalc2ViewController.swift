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
    
    let pickdata:[NSDictionary] = [
        ["name":"kanthal A-1","ohm":NSDecimalNumber(string: "1.45")],
        ["name":"kanthal A","ohm":NSDecimalNumber(string: "1.39")],
        ["name":"kanthal D","ohm":NSDecimalNumber(string: "1.35")],
        ["name":"NiCr","ohm":NSDecimalNumber(string: "1.08")],
        ["name":"Inox 316L","ohm":NSDecimalNumber(string: "0.75")],
        ["name":"Variable","ohm":NSDecimalNumber(string: "1.00")]
    ]
    
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
    
    @IBAction func editEnd() {
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
        
        let p: NSDecimalNumber = NSDecimalNumber(string: self.materialOhms.text).decimalNumberByDividingBy(NSDecimalNumber(string: "1000"))
        let K: NSDecimalNumber = NSDecimalNumber(string: "0")
        let Pi: NSDecimalNumber = NSDecimalNumber(string: "3.141592654")
        let n: NSDecimalNumber = NSDecimalNumber(string: self.turns.text)
        let d: NSDecimalNumber = NSDecimalNumber(string: self.diameterText.text)
        let D1: NSDecimalNumber = NSDecimalNumber(string: self.boreText.text)
        let D2: NSDecimalNumber = D1.decimalNumberByAdding(d).decimalNumberByAdding(d)
        let paralleldec: NSDecimalNumber = NSDecimalNumber(int: (self.parallel.selectedSegmentIndex + 1))
        let batteryVdec: NSDecimalNumber = NSDecimalNumber(string: self.batteryVText.text)
        
        var L: NSDecimalNumber = D1.decimalNumberByAdding(D2)
        L = L.decimalNumberByDividingBy(NSDecimalNumber(string: "2"))
        L = L.decimalNumberByMultiplyingBy(n)
        L = L.decimalNumberByMultiplyingBy(Pi)
        L = L.decimalNumberByAdding(K)
        
        var S: NSDecimalNumber = d.decimalNumberByDividingBy(NSDecimalNumber(string: "2"))
        S = S.decimalNumberByMultiplyingBy(S)
        S = S.decimalNumberByMultiplyingBy(Pi)
        
        var R: NSDecimalNumber = L.decimalNumberByDividingBy(S)
        R = p.decimalNumberByMultiplyingBy(R)
        R = R.decimalNumberByDividingBy(paralleldec)
        
        let powerdec: NSDecimalNumber = batteryVdec.decimalNumberByMultiplyingBy(batteryVdec).decimalNumberByDividingBy(R)
        
        let rounding: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        Rdec = R.decimalNumberByRoundingAccordingToBehavior(rounding)
        Pdec = powerdec.decimalNumberByRoundingAccordingToBehavior(rounding)
        
        Rdecinit = NSDecimalNumber(string: "0")
        Pdecinit = NSDecimalNumber(string: "0")

        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector:"numberToR:",userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector:"numberToP:",userInfo: nil, repeats: true)
    }
    
    var Rdecinit: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Pdecinit: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Rdec: NSDecimalNumber = NSDecimalNumber(string: "0")
    var Pdec: NSDecimalNumber = NSDecimalNumber(string: "0")
    
    func numberToR(tUpdate:NSTimer) {
        Rdecinit = Rdecinit.decimalNumberByAdding(Rdec.decimalNumberByDividingBy(NSDecimalNumber(string: "20")))
        self.ohms.text = Rdecinit.stringValue
        if (Rdecinit.compare(Rdec) == .OrderedDescending) {
            tUpdate.invalidate()
            self.ohms.text = Rdec.stringValue
        }
    }
    
    func numberToP(tUpdate:NSTimer) {
        Pdecinit = Pdecinit.decimalNumberByAdding(Pdec.decimalNumberByDividingBy(NSDecimalNumber(string: "20")))
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
        calc()
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
        self.materialBtn.setTitle(self.pickdata[self.pickerview.selectedRowInComponent(0)].objectForKey("name") as? String, forState: UIControlState.Normal)
        let ohms = self.pickdata[self.pickerview.selectedRowInComponent(0)].objectForKey("ohm") as? NSDecimalNumber
        self.materialOhms.text = ohms?.stringValue
        calc()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickdata.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickdata[row].objectForKey("name") as? String
    }
    
}
