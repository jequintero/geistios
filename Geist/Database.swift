//
//  Database.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 04/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit
import SQLite

class Database: NSObject {
    static var db: Connection!
    static var message: Table!
    
    static func initDB(){
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            
            message = Table("Message")
            
            let id = Expression<Int64>("id")
            let from = Expression<Int64?>("from")
            let to = Expression<Int64>("to")
            let sent_date = Expression<Date>("sent_date")
            let delivered_date = Expression<Date>("delivered_date")
            let read_date = Expression<Date>("read_date")
            let text = Expression<String>("text")
            let type = Expression<String>("type")
            
            do {
                try db.run(message.create(ifNotExists: true) { table in
                    table.column(id, primaryKey: true)
                    table.column(from)
                    table.column(to)
                    table.column(sent_date)
                    table.column(delivered_date)
                    table.column(read_date)
                    table.column(text)
                    table.column(type)
                })
            }catch{
                print("Hm, cant create db. \(error)")
            }
            
        }catch{
            print("Hm, something is wrong here.")
        }
    }
    
    static func insertMessage(message_object: Message){
        do{
            let insert = try Database.db.prepare("INSERT INTO Message ('id','from', 'to', 'sent_date', 'delivered_date', 'read_date', 'text', 'type') VALUES(?, ?, ?, ?, ?, ?, ?)")
            do{
                try insert.run(message_object.id, message_object.from, message_object.to, message_object.sent_date.toString(), message_object.delivered_date.toString(), message_object.read_date.toString(), message_object.text, message_object.type)
            }catch{
                print("Error on insert \(error)")
            }
        }catch{
            print("error \(error)")
        }
    }
}


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
