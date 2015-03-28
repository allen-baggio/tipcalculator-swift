//
//  TipViewController.swift
//  TipCalculatorSwift
//
//  Created by Le Guan on 3/24/15.
//  Copyright (c) 2015 Le Guan. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    let maxInputLength = 6
    @IBOutlet weak var billAmt: UITextField!
    @IBOutlet weak var tipAmt: UILabel!
    @IBOutlet weak var totalAmt: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    @IBOutlet weak var customTipPercent: UITextField!
    @IBOutlet weak var percentSign: UILabel!
    @IBOutlet weak var error: UILabel!
    @IBAction func clearBill(sender: AnyObject) {
        self.error.hidden = true
        self.billAmt.text = nil
    }
    @IBAction func clearCustomTip(sender: AnyObject) {
        self.error.hidden = true
        self.customTipPercent.text = nil
    }
    @IBAction func changeTip(sender: AnyObject) {
        self.error.hidden = true
        update()
    }
    @IBAction func tap(sender: AnyObject) {
        self.error.hidden = true
        update()
        self.billAmt.endEditing(true)
        self.customTipPercent.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.customTipPercent.hidden = true
        self.percentSign.hidden = true
        self.error.hidden = true
        update()
    }
    
    override func viewWillAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.blueColor()
        navigationItem.title = "TipCalculator"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
        self.billAmt.keyboardType = UIKeyboardType.DecimalPad
        if countElements(self.billAmt.text) > maxInputLength {
            self.error.hidden = false
            self.billAmt.text = nil
            update()
            return
        }
        
        let billAmtFloat = (self.billAmt.text as NSString).floatValue
        
        var tip = [Float(0.1), Float(0.15), Float(0.2)]
        var index = self.tipPercent.selectedSegmentIndex
        var tipPercentVal: Float = 0
        // check which tab user selects, if user selects custom, then display custom tip text field
        if index == 3 {
            self.customTipPercent.hidden = false
            self.percentSign.hidden = false
            self.customTipPercent.keyboardType = UIKeyboardType.NumberPad
            if (countElements(self.customTipPercent.text) > maxInputLength) {
                self.error.hidden = false
                self.customTipPercent.text = nil
                return
            }
            tipPercentVal = (self.customTipPercent.text as NSString).floatValue / Float(100)
        } else {
            self.customTipPercent.hidden = true
            self.percentSign.hidden = true
            tipPercentVal = tip[index]
        }
        let tipAmtFloat = billAmtFloat * tipPercentVal
        self.tipAmt.text = NSString(format: "$%.2f", tipAmtFloat)
        self.totalAmt.text = NSString(format: "$%.2f", tipAmtFloat + billAmtFloat)
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
