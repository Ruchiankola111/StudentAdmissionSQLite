//
//  StudentDetails.swift
//  Assignment11
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudentDetails: UIViewController {
    public var email:String?
    var s1:Student = Student()
    public  let mylabel:UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.layer.borderWidth = 3
        label.layer.cornerRadius = 20
        label.numberOfLines = 0
        return label
    }()
    private let passButton:UIButton = {
        let button = UIButton()
        button.setTitle("Change Your Password", for: .normal)
        button.addTarget(self, action: #selector(passTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func passTapped() {
        let vc = Changepass()
        vc.student = s1
        navigationController?.pushViewController(vc, animated: true)
    }
    private let noticeButton:UIButton = {
        let button = UIButton()
        button.setTitle("View Notice", for: .normal)
        button.addTarget(self, action: #selector(noticeTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func noticeTapped() {
        let vc = Viewnotice()
        navigationController?.pushViewController(vc, animated: true)
    }
    private let BackButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(classTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func classTapped() {
        let vc = AdminLogin()
        navigationController?.pushViewController(vc,animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mylabel)
        view.addSubview(passButton)
        view.addSubview(noticeButton)
        view.addSubview(BackButton)
       // print(email!)
        s1 = SQLiteHandler.shared.executeSelect(email: email!)
        mylabel.text = " Id:- \(s1.id)\n Password:- \(s1.password) \n Name:- \(s1.name) \n Class:- \(s1.div) \n Phone:- \(s1.phone) \n Email:- \(s1.email) "
    }
    override func viewDidLayoutSubviews() {
        mylabel.frame = CGRect(x: 20, y: 70, width: view.width - 40, height: 200)
        passButton.frame = CGRect(x: 20, y: mylabel.bottom + 30, width: view.width - 40, height: 40)
        noticeButton.frame = CGRect(x: 20, y: passButton.bottom + 30, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: noticeButton.bottom + 30, width: view.width - 40, height: 40)


    }

}
