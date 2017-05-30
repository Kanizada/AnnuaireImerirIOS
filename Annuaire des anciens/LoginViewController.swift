//
//  LoginViewController.swift
//  Annuaire des anciens
//
//  Created by Axel on 09/05/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Autoriser la connexion silencieuse
        GIDSignIn.sharedInstance().signInSilently()
		
    }
        
    
    //Affichage du Google Sign-In
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    //Masquage du Google Sign-In
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}


