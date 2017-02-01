//
//  ViewController.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 26/01/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FBSDKAccessToken.current() != nil{
            getFBUserData();
            
        }else{
            print("Not logged in")
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 50)
        
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
        
    }
    
    func initSocket(){
        let socket = SocketIOClient(socketURL: URL(string: "http://172.16.0.9:3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("chat") { data, ack in
            print("CHAT!!!!")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
    }
    
    //FBSDK
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error == nil{
            getFBUserData()
        }else{
            print(error.localizedDescription)
        }
    }
    
    func getFBUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, middle_name, last_name, email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                print("Error")
            } else {
                let json: JSON = JSON(result)
                let facebook_id = json["id"].string
                let facebook_key = json["id"].string!
                let middle_name = json["middle_name"].string ?? ""
                let names = "\(json["first_name"].string!) \(middle_name)"
                let surnames = json["last_name"].string!
                let email = json["email"].string ?? ""
                
                let params:[String: String] = [
                    "facebook_key" : facebook_key,
                    "names" : names,
                    "surnames": surnames,
                    "email": email,
                    "user_image": "https://graph.facebook.com/\(json["id"].string!)/picture?type=normal"]
                
                
                
                self.findFriend()
                /*Alamofire.request("\(Utilities.url)auth/login", method: .post, parameters: params).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        print("GOGO")
                        if let json :JSON = JSON(response.result.value) {
                            print(response.result.value ?? " ")
                            //Me.init(item: json)
                            //self.performSegue(withIdentifier: "init", sender: self)
                        }
                    case .failure:
                        print("Error")
                    }
                }*/
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    
    func findFriend(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields": "uid"])
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                print("Error")
            } else {
                let json = JSON(result)
                print(json)
            }
        })
    }

}

