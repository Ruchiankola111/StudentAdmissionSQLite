//
//  ViewController.swift
//  NewNotes10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var stdArray = [Student]()
    private let myTableView = UITableView()
    private let toolbar:UIToolbar = {
        let toolbar = UIToolbar()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        toolbar.items = [space,add]
        return toolbar
    }()
    @objc func handleAdd(){
        print("Add Button Called")
        let vc = NewStudent()
        navigationController?.pushViewController(vc, animated: true)
    }
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
        
        stdArray = SQLiteHandler.shared.fetch()
        
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)


        //let temp = SQLiteHandler.shared
        
        
        setupTableView()
        view.addSubview(toolbar)
        view.addSubview(myTableView)
        view.addSubview(BackButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let toolbarHGeight:CGFloat = view.safeAreaInsets.top + 20.0
        toolbar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height:toolbarHGeight)
        myTableView.frame = CGRect(x: 0, y: toolbar.bottom, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        BackButton.frame = CGRect(x: 0, y: view.height - 40, width: view.width, height: 40)
    }
    
}

extension ViewController :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Statecell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Statecell", for: indexPath)
        let std = stdArray[indexPath.row]
        cell.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 20
        cell.textLabel!.numberOfLines = 0
        cell.textLabel?.text = " Id:- \(std.id)\n Password:- \(std.password) \n Name:- \(std.name) \n Class:- \(std.div) \n Phone:- \(std.phone) \n Email:- \(std.email)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        let vc = NewStudent()
        vc.student = stdArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let id = stdArray[indexPath.row].id
        
        SQLiteHandler.shared.delete(for: id) { success in
            
            if success {
                self.stdArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("Unable to Delete from View Controller.")
            }
        }
    }
}




