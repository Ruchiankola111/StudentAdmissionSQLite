//
//  NewNotice.swift
//  ass11
//
//  Created by DCS on 21/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNotice: UIViewController {
    var student:Notice?
    
    let temp = SQLiteHandler.shared
    
    public let nameTextField1:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let classTextField2:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Description"
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
        button.layer.cornerRadius = 5
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
        let title = nameTextField1.text!
        let description = classTextField2.text!
        
        if let stud = student {
            MyButton.setTitle("Update", for: .normal)
            let updatedStud = Notice(nid: stud.nid, title: title, description: description)
            print("Update \(updatedStud)")
            update(stud: updatedStud)
            navigationController?.popViewController(animated: true)
        } else {
            let No = Notice(nid: 1,title: title, description: description)
            print("INSERT \(title), \(description)")
            insert(stud: No)
            navigationController?.popViewController(animated: true)
        }
    }
    private func insert(stud: Notice){
        SQLiteHandler.shared.insertNotice(no: stud) { [weak self] (success) in
            if success {
                print("Success : Insert successfull, received message at View Controller ")
                self?.resetFields()
            } else {
                print("Failure: Insert failed, received message at View Controller ")
            }
        }
    }
    
    private func update(stud: Notice){
        SQLiteHandler.shared.updateNotice(no: stud) { [weak self] (success) in
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
        nameTextField1.text = ""
        classTextField2.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField1)
        view.addSubview(classTextField2)
        view.addSubview(MyButton)
        view.addSubview(BackButton)
        
        if let stud = student {
            nameTextField1.text = stud.title
            classTextField2.text = stud.description
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField1.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 40)
        classTextField2.frame = CGRect(x: 20, y:nameTextField1.bottom + 10, width: view.width - 40, height: 40)
        MyButton.frame = CGRect(x: 20, y: classTextField2.bottom + 10, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: MyButton.bottom + 10 , width: view.width - 40, height: 40)
    }
    
}
