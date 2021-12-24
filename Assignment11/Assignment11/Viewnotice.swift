//
//  Viewnotice.swift
//  Assignment11
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Viewnotice: UIViewController {
    
        private var studArray = [Notice]()
        
        private let myTableView = UITableView()
        public  let noname:UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 30)
            label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            label.text = "NoticeBoard"
            return label
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
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            studArray = SQLiteHandler.shared.fetchNotice()
            
            myTableView.reloadData()
            
        }
        override func viewDidLoad() {
            
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(noname)
            myTableView.reloadData()
            myTableView.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))
            setupTableView()
            
            view.addSubview(myTableView)
            view.addSubview(BackButton)
            
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            noname.frame = CGRect(x: view.width - 280, y: 0, width: 300, height: 60)
            myTableView.frame = CGRect(x: 0, y: noname.bottom , width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
            BackButton.frame = CGRect(x: 0, y: view.height - 40, width: view.width, height: 40)
        }
        
    }
    
    extension Viewnotice :UITableViewDataSource,UITableViewDelegate {
        private func setupTableView()
        {
            myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Scell")
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return studArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Scell", for: indexPath)
            let stud = studArray[indexPath.row]
            cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10 ,left: 10, bottom: 10, right: 10))
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            cell.layer.cornerRadius = 25
            cell.textLabel!.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            cell.layer.borderWidth = 3
            cell.layer.shadowRadius = 3
            cell.layer.shadowOpacity = 0.3
            cell.textLabel!.numberOfLines = 0
            cell.textLabel?.text = "Title : \(stud.title) \nDescription : \(stud.description)  "
            return cell
        }
        
        
        
}
