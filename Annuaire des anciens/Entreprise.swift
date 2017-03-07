//
//  Entreprise.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

class Entreprise: DataString {
    var id : Int = 1
    var nom : String = "Google"
    var adresse : String = "Silicon Valley"
    var code_postal : String = "66000"
    var telephone : String = "00000000"
    var email : String = "contact@google.com"
    
    func getString() -> String {
        return self.nom
    }
    
}
