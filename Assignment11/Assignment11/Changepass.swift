//
//  Changepass.swift
//  Assignment11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Changepass: UIViewController {
    var student:Student?
    
    let temp = SQLiteHandler.shared
    
    private let passTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter New Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.isSecureTextEntry = true
        return  textField
    }()
    private let MyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(OnButtonClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    private let BackButton:UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(classTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func classTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func OnButtonClick()
    {
        let password = passTextField.text!
        if let s = student {
            let updatedStd = Student(id: s.id, password: password, name: s.name, div: s.div, phone: s.phone, email: s.email)
            print("Update \(updatedStd.id)")
            update(std: updatedStd)
           // navigationController?.popViewController(animated: true)
            let vc = StudentDetails()
            vc.email = s.email
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    private func update(std: Student){
        SQLiteHandler.shared.update(std: std) { [weak self] (success) in
            if success {
                print("Success : Update successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Update failed, received message at View Controller ")
            }
        }
    }
    
    private func resetFields() {
        
        passTextField.text = ""
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      view.addSubview(passTextField)
      view.addSubview(MyButton)
        view.addSubview(BackButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        passTextField.frame  = CGRect(x: 20, y: 80, width: view.width - 40, height: 60)
        MyButton.frame = CGRect(x: 20, y: passTextField.bottom + 30, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: MyButton.bottom + 30, width: view.width - 40, height: 40)
    }

   
}
