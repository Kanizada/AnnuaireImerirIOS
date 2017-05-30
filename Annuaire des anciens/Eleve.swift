//
//  Eleve.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

//classe qui permet d'ordonner les données dans chaque champs
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
	
	// fonction qui créer un objet eleve et qui rempli chaque champ de donnée avec les donnée de la base de donnée
    func construct(datas: JSON){
        //TODO with JSON
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
		eleve.append([self.nom])
		eleve.append([self.prenom])
		eleve.append([self.email])
		eleve.append([self.telephone_mobile])
		eleve.append([self.telephone_fixe])
		eleve.append([self.site_web])
		eleve.append([self.adresse])
		eleve.append([self.code_postal])
		eleve.append([self.ville])
		//Pour les eleves
		//entreprise.append(contentOf: entreprise.eleves)
		return eleve
	}
	
}
