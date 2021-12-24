//
//  ClassWiseStud.swift
//  66_Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ClassStud: UIViewController {
    private var studArray = [Student]()
    private let myTableView = UITableView()
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
        
        studArray = SQLiteHandler.shared.fetchClass()
        
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myTableView.reloadData()
        view.addSubview(BackButton)
        //let temp = SQLiteHandler.shared
        
        setupTableView()
        //        let temp = UIImageView(image: UIImage(named: "jsbg"))
        //        temp.frame = self.myTableView.frame
        //        self.myTableView.backgroundView = temp
        view.addSubview(myTableView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTableView.frame = CGRect(x: 0, y: 0, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 20)
        BackButton.frame = CGRect(x: 0, y: view.height - 40, width: view.width, height: 40)

    }
    
}

extension ClassStud :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Classcell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Classcell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.layer.cornerRadius = 25
        cell.textLabel!.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.layer.borderWidth = 3
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        cell.textLabel?.text = "\(stud.div)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        let stud = studArray[indexPath.row]
        let vc = ClassList()
        vc.selClass = String(stud.div)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
