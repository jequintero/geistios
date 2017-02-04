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
    func initDB(){
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            let db = try Connection("\(path)/db.sqlite3")
            
            let message = Table("Message")
            let id = Expression<Int64>("id")
            let from = Expression<Int64?>("from")
            let to = Expression<Int64>("to")
            let sent_date = Expression<Date>("sent_date")
            let delivered_date = Expression<Date>("delivered_date")
            let read_date = Expression<Date>("read_date")
            let text = Expression<String>("text")
            let type = Expression<String>("type")
            
            try db.run(message.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(from)
                table.column(to)
                table.column(sent_date)
                table.column(delivered_date)
                table.column(read_date)
                table.column(text)
                table.column(text)
                table.column(type)
            })
            
        }catch{
            print("Hm, something is wrong here.")
        }
        
        
    
        
    }

}
