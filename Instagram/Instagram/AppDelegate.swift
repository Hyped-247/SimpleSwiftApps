//
//  AppDelegate.swift
//  Instagram
//
//  Created by Mohammad on 5/21/18.
//  Copyright © 2018 Mohammad Mahjoub. All rights reserved.
//

import UIKit
import NXOAuth2Client
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var loginFromApp : () -> () = {() -> () in}
    var logoutFromApp : () -> () = {() -> () in}
    let outGoingRedirect : String = "http://djp3.westmont.edu/classes/2015-coursera-live/redirect.php/mayterm2018/thing.com"
    let inComingRedirct = "mayterm2018://thing.com"
    let myAuthorizationURL : NSURL = NSURL.init(string:"https://api.instagram.com/oauth/authorize?scope=follower_list")!
    let myTokenURL : NSURL = NSURL.init(string:"https://api.instagram.com/oauth/access_token")!
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let x = NXOAuth2AccountStore.sharedStore(){
            let accoutStore = x as! NXOAuth2AccountStore
            let myRedirectURL : NSURL = NSURL.init(string:self.outGoingRedirect)!
            
            accoutStore.setClientID("e9486eaf1eda4f22bd1ce8817f1e5b39", secret: "d93bcc195da3480880bba4c55d24a10d", authorizationURL: myAuthorizationURL as URL, tokenURL: myTokenURL as URL, redirectURL: myRedirectURL as URL, forAccountType: "Instagram")
            
        }
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let x = NXOAuth2AccountStore.sharedStore(){
            let accountStore = x as! NXOAuth2AccountStore
            if let scheme = url.scheme, let host = url.host, let query = url.query {
                if self.inComingRedirct.contains(scheme) &&  self.inComingRedirct.contains(host){
                    self.loginFromApp()
                    if let constructed = NSURL.init(string:"\(self.outGoingRedirect)?\(query)") {
                        return accountStore.handleRedirectURL(constructed as URL)
                    }

                }
            }
            return accountStore.handleRedirectURL(nil)
        }
        return false
    }

    
    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

