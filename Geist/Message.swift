//
//  Message.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 05/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit

class Message: NSObject {
    var id: Int!
    var from: Int!
    var to: Int! = nil
    var sent_date: Date!
    var delivered_date: Date!
    var read_date: Date!
    var text: String!
    var type: String!
    
    init(id: Int, from: Int, to: Int, sent_date: Date, delivered_date: Date, read_date: Date, text: String, type: String) {
        self.id = id
        self.from = from
        self.to = to
        self.sent_date = sent_date
        self.delivered_date = delivered_date
        self.read_date = read_date
        self.text = text
        self.type = type
    }
    
}
