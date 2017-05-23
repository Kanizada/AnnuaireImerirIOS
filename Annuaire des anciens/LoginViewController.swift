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
        GIDSignIn.sharedInstance().hostedDomain = "imerir.com"
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view.
    }
        
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}


