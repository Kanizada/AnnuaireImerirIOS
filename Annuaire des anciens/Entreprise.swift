//
//  Entreprise.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON


class Entreprise {
    var id : Int = 1
    var nom : String = "Google"
    var adresse : String = "Silicon Valley"
    var code_postal : String = "66000"
    var telephone : String = "00000000"
    var email : String = "contact@google.com"
    
    func construct(datas: JSON){
        //TODO with JSON
        self.nom = datas["nom"].stringValue
        self.adresse = datas["adresse"].stringValue
        self.email = datas["email"].stringValue
        self.telephone = datas["telephone"].stringValue
        self.code_postal = datas["code_postal"].stringValue
    }
	
	func getArray()->[[String]]{
		var entreprise: [[String]] = []
		entreprise.append([self.nom])
		entreprise.append([self.adresse])
		entreprise.append([self.code_postal])
		entreprise.append([self.telephone])
		entreprise.append([self.email])
		//Pour les eleves
		//entreprise.append(contentOf: entreprise.eleves)
		return entreprise
	}
}
