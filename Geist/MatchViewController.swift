//
//  MatchViewController.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 01/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import SQLite

class MatchViewController: EmbeddedViewController{
    
    @IBOutlet var background: SKView!
    @IBOutlet var login_button: UIButton!
    
    @IBOutlet var loader: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        
        //Adding particles background
        
        //ContainerViewController.shouldSh
        
        let background_scene = SKScene(fileNamed: "DynamicBackgroundScene")
        background_scene?.size = self.view.frame.size
        background.presentScene(background_scene)
        background_scene?.backgroundColor = .clear
        background.allowsTransparency = true
        
        let smoke: SKEmitterNode = SKEmitterNode(fileNamed: "Smoke.sks")!
        background_scene?.addChild(smoke)
        
        login_button.alpha = 0
        login_button.isHidden = true
        
        validateFBSession()
        
        let params = ["JO":"JE"]
        
        /*Alamofire.request("http://localhost:3000/match", method: .post, parameters: params).validate().responseJSON { response in
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
        
        
        loader.type = .ballScaleRippleMultiple
        loader.startAnimating()

        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
//    }
    
    func match(){
        var request = URLRequest(url: URL(fileURLWithPath: Utilities.url))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let values = ["06786984572365", "06644857247565", "06649998782227"]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: values)
        
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                }
        }
    }
    
    //FB
    
    func validateFBSession(){
        
        //If found fb session get user data, else show the fb button
        if FBSDKAccessToken.current() != nil{
            getFBUserData();
        }else{
            login_button.isHidden = false
            login_button.alpha = 1
        }

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()

        fbLoginManager.logIn(withReadPermissions:["public_profile", "email", "user_friends", "user_birthday"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, middle_name, last_name, email, birthday, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    Database.initDB()
                    /* */
                    
                    let json: JSON = JSON(result)
                    print(json)
                    var names = json["first_name"].string!
                    if json["middle_name"].string != ""{
                        names = "\(names) \(json["middle_name"])"
                    }
                    let params = ["names": names,
                                  "surnames": json["last_name"].string ?? "",
                                  "email": json["email"].string ?? "",
                                  "birth_date": json["birthday"].string ?? "",
                                  "gender": json["gender"].string ?? "",
                                  "facebook_id": json["id"].string!,
                                  "user_image": "https://graph.facebook.com/\(json["id"].string!)/picture?height=400"]

                    
                    Alamofire.request("http://localhost:3000/auth/login", method: .post, parameters: params).validate().responseJSON { response in
                        switch response.result {
                        case .success:
                            print("GOGO")
                            if let json :JSON = JSON(response.result.value) {
                                print(json)
                                //Me.init(item: json)
                                //self.performSegue(withIdentifier: "init", sender: self)
                            }
                        case .failure:
                            print("Error en login")
                        }
                    }
                    
                    
                    
                    //self.findFriend()
                    self.login_button.alpha = 0
                    self.login_button.isHidden = true
                    print("Access token \(FBSDKAccessToken.current().tokenString)")
                    /*let params:[String: String] = [
                        "acess_token" : ""]
                        
                    Alamofire.request("\(Utilities.url)match", method: .post, parameters: params).validate().responseJSON { response in
                        switch response.result {
                        case .success:
                            print("GOGO")
                            if let json :JSON = JSON(response.result.value) {
                                
                                print(json)
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
        
        /*let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, middle_name, last_name, email"])
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
                
                
                
                self.findFriend()*/
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
                 }
            }
        })*/
    }
    
    func findFriend(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields": "uid"])
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                print("Error")
            } else {
                let json = JSON(result)
                let friends = json["data"]
                print(friends.array![0]["id"])
            }
        })
    }
}
