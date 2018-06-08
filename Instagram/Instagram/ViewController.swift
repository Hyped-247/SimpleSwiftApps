//
//  ViewController.swift
//  Instagram
//
//  Created by Mohammad on 5/21/18.
//  Copyright © 2018 Mohammad Mahjoub. All rights reserved.
//

import UIKit
import NXOAuth2Client
import os.log
class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var login: UIBarButtonItem!
    @IBOutlet weak var logout: UIBarButtonItem!
    @IBOutlet weak var ref: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutFun()
        let myApp = UIApplication.shared.delegate as! AppDelegate
        myApp.loginFromApp = { () -> () in
                DispatchQueue.main.async {
                    self.loginFun()
                    
                }
            }
        myApp.logoutFromApp = { () -> () in
            DispatchQueue.main.async {
                self.logoutFun()
                
            }
        }
    }
        
        
        
        
    @IBAction func loginUser(_ sender: Any) {
        if let x = NXOAuth2AccountStore.sharedStore(){
            let accoutStore = x as! NXOAuth2AccountStore
            accoutStore.requestAccessToAccount(withType: "Instagram")
            self.login.isEnabled = false
        }
    }
    
    @IBAction func logoutUser(_ sender: Any) {
        
        if let x = NXOAuth2AccountStore.sharedStore(){
            let accoutStore = x as! NXOAuth2AccountStore
            if let accounts = accoutStore.accounts(withAccountType: "Instagram") {
                for y in accounts {
                    let account = y as! NXOAuth2Account
                    accoutStore.removeAccount(account)
                }
            }
            self.logoutFun()
        }
    }
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionDataTask?
    
    
    func fetchImage(urlToFetch : String) {
        if let url = URL(string:urlToFetch){
            dataTask?.cancel()
            dataTask = defaultSession.dataTask(with: url, completionHandler: {
                (data, response, error) -> Void in
                if let error = error {
                    os_log("Couldn't reach the server because of %@", type: .error,
                           error.localizedDescription)
                    
                    return
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode < 200 || response.statusCode >= 300 {
                        os_log("Server responded with error. status code: %d", type: .error,
                               response.statusCode)
                    }
                    
                    if let data = data {
                        DispatchQueue.main.sync {
                            self.image.image = UIImage(data: data)
                        }
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    
    
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        if let x = NXOAuth2AccountStore.sharedStore() {
            let accountStore = x as! NXOAuth2AccountStore
            if let accounts = accountStore.accounts(withAccountType: "Instagram") {
                if accounts.count < 1 {
                    return
                }
            
            let account = accounts[0] as! NXOAuth2Account
            let token = account.accessToken.accessToken
            dataTask?.cancel()
                
            if var urlComponents = URLComponents(string: "https://api.instagram.com/v1/users/self/media/recent") {
                
                urlComponents.query = "access_token=\(token!)"
                guard let url = urlComponents.url else {return}
                dataTask = defaultSession.dataTask(with: url, completionHandler: {
                    (data, response, error) -> Void in
                    if let error = error {
                        os_log("Couldn't reach the server because of %@", type: .error,
                               error.localizedDescription)
                        
                        return
                    }
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode < 200 || response.statusCode >= 300 {
                            os_log("Server responded with error. status code: %d", type: .error,
                                   response.statusCode)
                        }
                    }
                    
        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let json = json as? [String:Any] {
                    if let json = json["data"] as? [Any] {
                        if let json = json[0] as? [String:Any] {
                            if let json = json["images"] as? [String:Any] {
                                if let json = json["standard_resolution"] as? [String:Any] {
                                    if let url = json["url"] as? String {
                                        self.fetchImage(urlToFetch:url)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    })
                dataTask?.resume()
}
}
}
}
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginFun() {
        self.login.isEnabled = false
        self.ref.isEnabled = true
        self.logout.isEnabled = true
    }
    
    func logoutFun() {
        self.login.isEnabled = true
        self.ref.isEnabled = false
        self.logout.isEnabled = false
    }
}

