//
//  SocketIOManager.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 01/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import Foundation

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket = SocketIOClient(socketURL: URL(string: "http://172.16.0.9:3000")!, config: [.log(false), .forcePolling(true)])
    
    override init() {
        super.init()
        
        socket.on("connect") { dataArray, ack in
            print("CONECTADO")
            print(dataArray)
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
