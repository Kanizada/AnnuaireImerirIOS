//
//  Eleve.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

class Eleve {
    var key : String = "001"
    //API key of the user
    
    var nom : String = "Name"
    //Last name of student
    
    var prenom : String = "First name"
    //First name of student
    
    var email : String = "name.firstname@my-mail.com"
    //Email of student
    
    var date_inscription : String = "01/01/01"
    //Register date of student
    
    var telephone_mobile : String = "0600000000"
    //Mobile phone of student
    
    var telephone_perso : String = "000000000"
    //Personnal phone of student
    
    var site_web : String = "http://pfffff.com"
    //Website of student
    
    var adresse : String = "my home"
    //Address of student
    
    var code_postal : String = "66000"
    //Postal code of student
	
	var ville: String = "Perpignan"
    
    func construct(datas: JSON){
        //TODO with JSON
        self.nom = datas["nom"].stringValue
        self.prenom = datas["prenom"].stringValue
        self.email = datas["email"].stringValue
        self.date_inscription = datas["date_inscription"].stringValue
        self.telephone_mobile = datas["telephone_mobile"].stringValue
        self.telephone_perso = datas["telephone_fixe"].stringValue
        self.site_web = datas["site_web"].stringValue
        self.adresse = datas["adresse"].stringValue
        self.code_postal = datas["code_postal"].stringValue
		self.ville = datas["ville"].stringValue
    }
	
	func getArray()->[[String]]{
		var eleve: [[String]] = []
		eleve.append([self.nom])
		eleve.append([self.prenom])
		eleve.append([self.email])
		eleve.append([self.telephone_mobile])
		eleve.append([self.telephone_perso])
		eleve.append([self.site_web])
		eleve.append([self.adresse])
		eleve.append([self.code_postal])
		eleve.append([self.ville])
		//Pour les eleves
		//entreprise.append(contentOf: entreprise.eleves)
		return eleve
	}
	
}
