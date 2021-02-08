//
//  DBManager.swift
//  FlightHelper
//
//  Created by skk on 2021/1/31.
//  Copyright © 2021 deepBlue. All rights reserved.
//

import Foundation
import SQLite3


class DBManager: NSObject {

    var db: OpaquePointer? = nil
    
    static let instance = DBManager()

    class func shareInstance() -> DBManager {
        return instance
    }
    
    func openDB() -> Bool {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        print(filePath)
        let file = filePath + "/test.sqlite"
        let cfile = file.cString(using: String.Encoding.utf8)
        let state = sqlite3_open(cfile, &db)
        if state != SQLITE_OK {
            print("Open Database Falied")
            return false
        }
        return (createTable() && createDefault())
    }

    func execSql(_ sql: String) -> Bool {
        let csql = sql.cString(using: String.Encoding.utf8)
        return sqlite3_exec(db, csql, nil, nil, nil) == SQLITE_OK
    }
    
    func querySql(_ sql: String) -> [Flight] {
        var stmt: OpaquePointer? = nil
        let csql = (sql.cString(using: String.Encoding.utf8))!

        var flights = [Flight]()

        if sqlite3_prepare(db, csql, -1, &stmt, nil) != SQLITE_OK {
            print("Flight Database Unprepared")
            return flights
        }
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = Int.init(sqlite3_column_int(stmt, 0))
            let originID = Int.init(sqlite3_column_int(stmt, 1))
            let destinationID = Int.init(sqlite3_column_int(stmt, 2))
            let price = Int.init(sqlite3_column_int(stmt, 3))
            flights.append(Flight(id, originID, destinationID, price))
        }
        return flights
    }
  
    
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS t_flight (id integer PRIMARY KEY, originID integer, destinationID integer, price integer)"
        return execSql(sql)
    }
    
    func createDefault() -> Bool {
        let sql = "INSERT INTO t_flight VALUES\(DefaultData.flights)"
        return execSql(sql)
    }
    
    func create() {
        // TODO
    }
    
    func retrieve(_ keyword: Int, by: String) -> [Flight] {
        let sql = "SELECT * FROM t_flight WHERE \(by)=\(keyword)"
        return querySql(sql)
    }
    
    func retrieve2(_ originID: Int, _ destinationID: Int) -> [Flight] {
        let sql = "SELECT * FROM t_flight WHERE originID=\(originID) AND destinationID=\(destinationID)"
        return querySql(sql)
    }
    
    func retrieveAll() -> [Flight] {
        let sql = "SELECT * FROM t_flight"
        return querySql(sql)
    }

    func update() {
        // TODO
    }
    
    func delete() {
        // TODO
    }
    
    func deleteAll() -> Bool {
        let sql = "DELETE FROM t_flight"
        return execSql(sql)
    }
        
}
