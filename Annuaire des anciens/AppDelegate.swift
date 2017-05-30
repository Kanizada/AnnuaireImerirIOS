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
    
	//URL de l'api pour récupérer la dernière version de la base de données
    let dbVersionUrl = "http://vps366535.ovh.net/api/dbversion/cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
	
	
    var dbVersion : String!
	
	//Fonction de comparaison de la version
    func runCheck(){
        let v = getVersion()
		
		//Si la version est différente alors affichage de l'alerte
        if dbVersion != v {
			
			//Création de l'alerte
            let alert = UIAlertController(title: "Données mise à jour", message: "Les données ont été mise à jour, redémarrez l'application pour charger les nouvelles données.", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
			
			//Récupération du topController
			if var topController = window?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
            }
			
			//Invalidation du timer après l'avertissement
            checkTimer.invalidate()
        }
    }
	
    //Fonction de récupération de la version
    func getVersion()->String{
        let url = URL(string: dbVersionUrl)
        let data = try? Data(contentsOf: url!)
        let json = JSON(data: data!)
        let v = json[0]["UPDATE_TIME"].stringValue
        return v
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        // Initialisation du Google Sign-In
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
		
		//Configuration du domaine pour limiter à l'Imerir
        GIDSignIn.sharedInstance().hostedDomain = "imerir.com"

		
        GIDSignIn.sharedInstance().delegate = self
		
		//Récupération de la version de la base de données
		dbVersion = self.getVersion()
		
		//Démarrage du timer de check
		checkTimer = Timer.scheduledTimer(timeInterval: 5*60, target: self, selector: #selector(runCheck), userInfo: nil, repeats: true)
		
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // Listener Google Sign-In après la connexion
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                withError error: Error!) {
        if (error == nil) {
			
            //Connexion réussi
            let viewController = self.window!.rootViewController
            viewController?.performSegue(withIdentifier: "logged", sender: nil)
            
        } else {
			
			//Connexion échoué
            print("dont worked \(error.localizedDescription)")
        }
    }
	
    // Listener Google Sign-In après la deconnexion
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

