//
//  Login.swift
//  Ass10NotesApp
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminLogin: UIViewController {
    let db = SQLiteHandler.shared
    let s = ""
    public  let lname:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 55)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.text = "Login"
        return label
    }()
    public  let lerror:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.8426797945)
        label.textAlignment = .center
        label.text = "Invalid Username And Password!!"
        return label
    }()
    
    private let emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username or email"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return  textField
    }()
    private let pwdTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.isSecureTextEntry = true
        return  textField
    }()
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(loginButton)
        view.addSubview(lname)
        view.addSubview(emailTextField)
        view.addSubview(pwdTextField)
        view.addSubview(lerror)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lname.frame  = CGRect(x: 20, y: 80, width: view.width - 40, height: 60)
        emailTextField.frame = CGRect(x: 20, y: lname.bottom + 300, width: view.width - 40, height: 40)
        pwdTextField.frame = CGRect(x: 20, y: emailTextField.bottom + 20, width: view.width - 40, height: 40)
        loginButton.frame = CGRect(x: 20, y: pwdTextField.bottom + 20, width: view.width - 40, height: 40)
    }
    
    @objc private func loginTapped() {
        if emailTextField.text == "Ruchita" {
            if emailTextField.text == "Ruchita" && pwdTextField.text ==  "Ruchita" {
                UserDefaults.standard.setValue("Ruchita", forKey: "username")
                UserDefaults.standard.setValue("Ruchita", forKey: "password")
                let vc = AdminHome()
                navigationController?.pushViewController(vc, animated: true)
           }
            else
            {
                lerror.frame = CGRect(x: 40, y: loginButton.bottom + 10, width: view.width - 80, height: 40)
                
            }
        }else
        {
            let ans = db.loginAuthentication(email: emailTextField.text!, password: pwdTextField.text!)
            if ans{
                print("valid")
                let vc = StudentDetails()
                vc.email = emailTextField.text
                navigationController?.pushViewController(vc, animated: true)
            }else {
                print("invaild")
            }
        
    }
    }
}
