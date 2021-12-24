//
//  SecondController.swift
//  NewNotes10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewStudent: UIViewController {
    
    var student:Student?
    
    let temp = SQLiteHandler.shared
    
    public let passTextField1:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.isSecureTextEntry = true
        return textField
    }()
    public let nameTextField2:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let divTextField3:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter class"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let phoneTextField4:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter phone number"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let emailTextField5:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter email number"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    private let MyButton:UIButton={
        let button=UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(OnInsertButtonClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    private let BackButton:UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(classTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    @objc private func classTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func OnInsertButtonClick()
    {
        let password = passTextField1.text!
        let name = nameTextField2.text!
        let div = divTextField3.text!
        let phone = phoneTextField4.text!
        let email = emailTextField5.text!
        
        if let std = student {
            MyButton.setTitle("Updated", for: .normal)
            let updatedStd = Student(id: std.id,password: password, name: name, div: div, phone: phone, email: email)
            print("Update \(updatedStd)")
            update(std: updatedStd)
            navigationController?.popViewController(animated: true)
            
        }else {
            let Std = Student(id: 1,password: password, name: name, div: div, phone: phone, email: email)
            print("INSERT \(password), \(name), \(div) ,\(phone) ,\(email)")
            insert(std: Std)
            navigationController?.popViewController(animated: true)

        }
    }
    private func insert(std: Student){
         print("INSERT std \(std.password), \(std.name), \(std.div) ,\(std.phone) ,\(std.email)")
        SQLiteHandler.shared.insert(std: std) { [weak self] (success) in
            if success {
                print("Success : Insert successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Insert failed, received message at View Controller ")
            }
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
        student = nil
        passTextField1.text = ""
        nameTextField2.text = ""
        divTextField3.text = ""
        phoneTextField4.text = ""
        emailTextField5.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationController?.setNavigationBarHidden(false, animated: true)

        view.addSubview(passTextField1)
        view.addSubview(nameTextField2)
        view.addSubview(divTextField3)
        view.addSubview(phoneTextField4)
        view.addSubview(emailTextField5)
        view.addSubview(MyButton)
        view.addSubview(BackButton)
        
        if let std = student {
            passTextField1.text = std.password
            nameTextField2.text = std.name
            divTextField3.text = std.div
            phoneTextField4.text = std.phone
            emailTextField5.text = std.email
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        passTextField1.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 40)
        nameTextField2.frame = CGRect(x: 20, y:passTextField1.bottom + 10, width: view.width - 40, height: 40)
        divTextField3.frame = CGRect(x: 20, y:nameTextField2.bottom + 10, width: view.width - 40, height: 40)
        phoneTextField4.frame = CGRect(x: 20, y: divTextField3.bottom + 10, width: view.width - 40, height: 40)
        emailTextField5.frame = CGRect(x: 20, y: phoneTextField4.bottom + 10, width: view.width - 40, height: 40)
        MyButton.frame = CGRect(x: 20, y: emailTextField5.bottom + 10, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: MyButton.bottom + 10, width: view.width - 40, height: 40)
    }
}



