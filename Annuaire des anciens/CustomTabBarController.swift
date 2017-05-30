//
//  CustomTabBarController.swift
//  Annuaire des anciens
//
//  Created by Student on 26/05/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    //Disconnect Button
    @IBAction func onPressDisconnect(_ sender: AnyObject) {		//Fonction qui sert a modifier le bouton back du
        GIDSignIn.sharedInstance().signOut()					//tabBarController pour qu'il renvoi directement a la 1ere vue
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
