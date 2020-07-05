//
//  ViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 17.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var uniTextField: UITextField!
    private let universityDataPicker = UIPickerView()
    
    var arrayPicker = ["ONPU","ONMA","ONMU"]
    var pickedUni: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        universityDataPicker.dataSource = self
        universityDataPicker.delegate = self
        
        nameTextField.text = UserSettings.userModel?.name
        surnameTextField.text = UserSettings.userModel?.surname
        
        let toolbar = UIToolbar()
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(handleSelected))
        toolbar.items = [spacing, okButton]
        toolbar.sizeToFit()
        
        uniTextField.inputView = universityDataPicker
        uniTextField.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedUni = arrayPicker[row]
    }
    
    @objc private func handleSelected() {
        uniTextField.resignFirstResponder()
        uniTextField.text = arrayPicker[universityDataPicker.selectedRow(inComponent: 0)]
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text, let surname = surnameTextField.text,let pickedUni = pickedUni, let uni = University(rawValue: pickedUni) else { return }
        
        let object = Student(name: name, surname: surname, uni: uni )
        UserSettings.userModel = object
        print("Data was saved")
    }
    
}

class Student: NSObject, NSCoding{
    
    var name: String
    var surname: String
    var uni: University
    
    init(name: String, surname: String, uni: University) {
        self.name = name
        self.surname = surname
        self.uni = uni
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name,forKey: "name")
        coder.encode(surname,forKey: "surname")
        coder.encode(uni.rawValue ,forKey: "uni")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
        uni = University(rawValue: (coder.decodeObject(forKey: "uni") as! String )) ?? University.ONPU
    }
    
}

enum University: String {
    case ONPU
    case ONMA
    case ONMU
}



