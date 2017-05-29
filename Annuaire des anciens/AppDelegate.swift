//
//  AppDelegate.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var checkTimer : Timer!
    

    let dbVersionUrl = "http://vps366535.ovh.net/api/dbversion/cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
    var dbVersion : String!
    
    func runCheck(){
        let v = getVersion()
        if dbVersion != v {
            let alert = UIAlertController(title: "Données mise à jour", message: "Les données ont été mise à jour, redémarrez l'application pour charger les nouvelles données.", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            if var topController = window?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
            }
            checkTimer.invalidate()
        }
    }
    
    func getVersion()->String{
        let url = URL(string: dbVersionUrl)
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        let v = json[0]["UPDATE_TIME"].stringValue
        return v
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
        var configureError: NSError?
        dbVersion = self.getVersion()
        checkTimer = Timer.scheduledTimer(timeInterval: 5*60, target: self, selector: #selector(runCheck), userInfo: nil, repeats: true)
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().hostedDomain = "imerir.com"

        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // Listener Google Sign In
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                withError error: Error!) {
        if (error == nil) {
            print("worked")
            let viewController = self.window!.rootViewController
            viewController?.performSegue(withIdentifier: "logged", sender: nil)
            
        } else {
            print("dont worked \(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

