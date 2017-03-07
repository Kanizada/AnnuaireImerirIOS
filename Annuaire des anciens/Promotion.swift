//
//  Promotion.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

class Promotion: DataString {
    var id : Int = 1
    var nom : String = "LeMeur"
    var annee : String = "2014"
    var promo_actuelle : Bool = false
    
    func getString() -> String {
        return self.nom
    }
}
