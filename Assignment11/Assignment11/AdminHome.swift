//
//  AdminHome.swift
//  Assignment11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminHome: UIViewController {
        private let stdButton:UIButton = {
            let button = UIButton()
            button.setTitle("Student Corner", for: .normal)
            button.addTarget(self, action: #selector(stdTapped), for: .touchUpInside)
            button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            button.layer.cornerRadius = 20
            return button
        }()
        @objc private func stdTapped() {
            let vc = ViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        private let noticeButton:UIButton = {
            let button = UIButton()
            button.setTitle("Notice Corner", for: .normal)
            button.addTarget(self, action: #selector(noticeTapped), for: .touchUpInside)
            button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            button.layer.cornerRadius = 20
            return button
        }()
        @objc private func noticeTapped() {
            let vc = AdminNoticeBoard()
            navigationController?.pushViewController(vc, animated: true)
        }
    private let classButton:UIButton = {
        let button = UIButton()
        button.setTitle("Class Corner", for: .normal)
        button.addTarget(self, action: #selector(classTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func classTapped() {
       let vc = ClassStud()
       navigationController?.pushViewController(vc, animated: true)
    }
    private let logoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    @objc private func logoutTapped() {
        let vc = AdminLogin()
        navigationController?.pushViewController(vc, animated: true)
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(classButton)
            view.addSubview(stdButton)
            view.addSubview(noticeButton)
            view.addSubview(logoutButton)
        }
        override func viewDidLayoutSubviews() {
            stdButton.frame = CGRect(x: 20, y: 200, width: view.width - 40, height: 60)
            classButton.frame = CGRect(x: 20, y: stdButton.bottom + 40, width: view.width - 40, height: 60)
            noticeButton.frame = CGRect(x: 20, y: classButton.bottom + 40, width: view.width - 40, height: 60)
            logoutButton.frame = CGRect(x: 20, y: noticeButton.bottom + 40, width: view.width - 40, height: 60)
            
        }
        
}

