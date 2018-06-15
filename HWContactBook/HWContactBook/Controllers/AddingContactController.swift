 //
 //  AddingContactController.swift
 //  HWContactBook
 //
 //  Created by Abai on 2/4/18.
 //  Copyright © 2018 Abai Kalikov. All rights reserved.
 //

import Foundation
import UIKit
class AddingContactController: UIViewController {
    
    @IBOutlet weak var new_name_lbl: UITextField!
    @IBOutlet weak var new_phone_lbl: UITextField!
    @IBOutlet weak var new_pickerView: UIPickerView!
    
    var value = "male"
    let gender = ["male", "female"]
    var receiver: Receiver?
    
    
    @IBAction func add_new_contact(_ sender: UIButton) {
        if value == "male" {
            receiver?.save(a: Contact(UIImage.init(named: "male")!, new_name_lbl.text!, new_phone_lbl.text!))
        } else {
            receiver?.save(a: Contact(UIImage.init(named: "female")!, new_name_lbl.text!, new_phone_lbl.text!))
        }
       
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddingContactController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        value = gender[row]
    }
    
}
