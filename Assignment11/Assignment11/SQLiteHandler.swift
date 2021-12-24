//
//  SQLiteHandler.swift
//  NewNotes10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3
class SQLiteHandler {
    
    static let shared = SQLiteHandler()
    
    let dbPath = "std1db.sqlite"
    var db:OpaquePointer?  //Database Pointer
    
    private init()
    {
        db=openDatabase()
        createTable()
        createTableNotice()
    }
    
    func openDatabase() -> OpaquePointer? {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbPath)
        
        var database:OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK {
            
            print("Opened Connection to the database successfully at : \(fileURL)")
            return database
        } else {
            print("error eonnecting to the database")
            return nil
        }
    }
    
    
    func createTable() {
        //Sql statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS std(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        password TEXT NOT NULL,
        name TEXT NOT NULL,
        div TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL);
        """
        
        //statement handle
        var createTableStatement:OpaquePointer? = nil
        
        //prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1 , &createTableStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("std table created")
            } else {
                print("std table could not be prepared")
            }
        }
        else
        {
            print("std table could not be prepared")
        }
        
        //delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(std:Student, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO std(password, name, div, phone, email) VALUES(?, ?, ?, ?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(insertStatement, 1, (std.password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (std.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (std.div as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (std.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (std.email as NSString).utf8String, -1, nil)

            //Evaluate sta
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted row succesfully")
                completion(true)
            } else {
                print("could not insert row")
                completion(false)
            }
            
        }
        else
        {
            print("insert statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(insertStatement)
        
    }
    
    func update(std:Student, completion: @escaping ((Bool) -> Void)) {
        let updateStatementString = "UPDATE std SET password = ?, name = ?, div = ?, phone = ?, email = ? WHERE id = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(updateStatement, 1, (std.password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (std.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (std.div as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (std.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (std.email as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 6, Int32(std.id))
            
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    
    func delete(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deleteStatementString = "DELETE FROM std WHERE id = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        //prepare deleteStatement
        if sqlite3_prepare_v2(db, deleteStatementString, -1 ,&deleteStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            //Evaluate statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("deleted row succesfully")
                completion(true)
            } else {
                print("could not delete row")
                completion(false)
            }
            
        }
        else
        {
            print("Delete statement could not be prepared")
            completion(false)
        }
        
        //delete deletestatement
        sqlite3_finalize(deleteStatement)
        
    }
    
    func fetch() -> [Student]{
        let fetchStatementString = "SELECT * FROM std;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var std = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let password = String(cString: sqlite3_column_text(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let div = String(cString: sqlite3_column_text(fetchStatement, 3))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 4))
                let email = String(cString: sqlite3_column_text(fetchStatement, 5))

                std.append(Student(id: id,password: password, name: name, div: div, phone: phone, email: email))
                print("\(id) |\(password)|  \(name)  |  \(div)  |  \(phone) | \(email)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return std
    }
    func fetchClass() -> [Student]{
        let fetchStatementString = "SELECT * FROM std GROUP BY div;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let password = String(cString: sqlite3_column_text(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let div = String(cString: sqlite3_column_text(fetchStatement, 3))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 4))
                let email = String(cString: sqlite3_column_text(fetchStatement, 5))
                
                stud.append(Student(id: id,password: password, name: name, div: div, phone: phone, email: email))
                print("\(div)")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        return stud
    }
    func studClassWise(for div:String, completion: @escaping ((Bool) -> Void)) -> [Student] {
        
        let fetchStatementString = "SELECT * FROM std WHERE div = ?;"
        var fetchStatement:OpaquePointer? = nil
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Binding Data
            sqlite3_bind_text(fetchStatement, 1, (div as NSString).utf8String, -1, nil)
            
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetched class stud succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let password = String(cString: sqlite3_column_text(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let div = String(cString: sqlite3_column_text(fetchStatement, 3))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 4))
                let email = String(cString: sqlite3_column_text(fetchStatement, 5))

                stud.append(Student(id: id,password: password, name: name, div: div, phone: phone, email: email))
                print("\(id) |\(password)|  \(name)  |  \(div)  |  \(phone) | \(email)")
                
               }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
  
    func loginAuthentication(email:String, password:String)->Bool{
        let query  = "select * from std where email = '"+email+"' and password = '"+password+"';"
        var queryStatement: OpaquePointer? = nil
        
        var b:Bool = false
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW
            {
                b = true
            }
        }else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("select into :: could not be prepared::\(errmsg)")
            b = false
        }
        sqlite3_finalize(queryStatement)
        return b
    }
    func executeSelect(email:String)->Student{
        let query  = "select * from std where email = '"+email+"';"
        var queryStatement: OpaquePointer? = nil
        
        var data:Student = Student()
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(queryStatement) == SQLITE_ROW
            {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let password = String(cString: sqlite3_column_text(queryStatement, 1))
                let name = String(cString: sqlite3_column_text(queryStatement, 2))
                let div = String(cString: sqlite3_column_text(queryStatement, 3))
                let phone = String(cString: sqlite3_column_text(queryStatement, 4))
                let email = String(cString: sqlite3_column_text(queryStatement, 5))
                
                data = Student(id: id,password: password, name: name, div: div, phone: phone, email: email)
            }
        }else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("select into :: could not be prepared::\(errmsg)")
            return data
            
        }
        sqlite3_finalize(queryStatement)
        return data
    }
    func createTableNotice() {
        //Sql statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS notice(
        nid INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
        );
        """
        
        //statement handle
        var createTableStatement:OpaquePointer? = nil
        
        //prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1 , &createTableStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("notice table created")
            } else {
                print("notice table could not be prepared")
            }
        }
        else
        {
            print("notice table could not be prepared")
        }
        
        //delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insertNotice(no:Notice, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO notice(title, description) VALUES(?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(insertStatement, 1, (no.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (no.description as NSString).utf8String, -1, nil)
            
            //Evaluate statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted notice row succesfully")
                completion(true)
            } else {
                print("could not insert notice row")
                completion(false)
            }
            
        }
        else
        {
            print("insert notice statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(insertStatement)
        
    }
    
    func updateNotice(no:Notice, completion: @escaping ((Bool) -> Void)) {
        let updateStatementString = "UPDATE notice SET title = ?, description = ? WHERE nid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_text(updateStatement, 1, (no.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (no.description as NSString).utf8String, -1, nil)
            
            sqlite3_bind_int(updateStatement, 3, Int32(no.nid))
            
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    
    func deleteNotice(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deleteStatementString = "DELETE FROM notice WHERE nid = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        //prepare deleteStatement
        if sqlite3_prepare_v2(db, deleteStatementString, -1 ,&deleteStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            //Evaluate statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("deleted notice row succesfully")
                completion(true)
            } else {
                print("could not delete notice row")
                completion(false)
            }
            
        }
        else
        {
            print("Delete notice statement could not be prepared")
            completion(false)
        }
        
        //delete deletestatement
        sqlite3_finalize(deleteStatement)
        
    }
    
    func fetchNotice() -> [Notice]{
        let fetchStatementString = "SELECT * FROM notice;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Notice]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let nid = Int(sqlite3_column_int(fetchStatement, 0))
                let title = String(cString: sqlite3_column_text(fetchStatement, 1))
                let description = String(cString: sqlite3_column_text(fetchStatement, 2))
                
                
                stud.append(Notice(nid: nid, title: title ,description: description))
                print("\(nid) |  \(title)  |  \(description)")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }

}


















