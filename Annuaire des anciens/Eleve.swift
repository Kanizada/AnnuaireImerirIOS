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
    var id : Int = 0
    
    var nom : String = "Name"
    //Last name of student
    
    var prenom : String = "First name"
    //First name of student
    
    var email : String = "name.firstname@my-mail.com"
    //Email of student
    
    var telephone_mobile : String = "0600000000"
    //Mobile phone of student
    
    var telephone_fixe : String = "000000000"
    //Personnal phone of student
    
    var site_web : String = "http://pfffff.com"
    //Website of student
    
    var adresse : String = "my home"
    //Address of student
    
    var code_postal : String = "66000"
    //Postal code of student
	
	var ville: String = "Perpignan"
    
    //TODO
    var entreprises : [Entreprise] = []
    
    func addEntreprise(entreprise : Entreprise){
        self.entreprises.append(entreprise)
    }
	
	// fonction qui créer un objet eleve et qui rempli chaque champs de données avec les données de la base de données
	init(json datas: JSON) {
        self.id = datas["id"].intValue
        self.nom = datas["nom"].stringValue
        self.prenom = datas["prenom"].stringValue
        self.email = datas["email"].stringValue
        self.telephone_mobile = datas["telephone_mobile"].stringValue
        self.telephone_fixe = datas["telephone_fixe"].stringValue
        self.site_web = datas["site_web"].stringValue
        self.adresse = datas["adresse"].stringValue
        self.code_postal = datas["code_postal"].stringValue
		self.ville = datas["ville"].stringValue
    }
	
	func getArray()->[[String]]{
		var eleve: [[String]] = []
        eleve.append([])
		eleve[0].append(self.nom)
		eleve[0].append(self.prenom)
		eleve[0].append(self.email)
		eleve[0].append(self.telephone_mobile)
		eleve[0].append(self.telephone_fixe)
		eleve[0].append(self.site_web)
		eleve[0].append(self.adresse)
		eleve[0].append(self.code_postal)
		eleve[0].append(self.ville)
        eleve.append([])
        for entreprise: Entreprise in entreprises {
            eleve[1].append(entreprise.nom)
        }
		//Pour les eleves
		//entreprise.append(contentOf: entreprise.eleves)
		return eleve
	}
	
}
