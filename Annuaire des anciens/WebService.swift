//
//  WebService.swift
//  Annuaire des anciens
//
//  Created by Student on 30/05/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import SwiftyJSON

enum type {
	case ELEVE
	case ENTREPRISE
	case NOT_INIT
}

class WebService {
	
	struct URLS {
		static let elevesList = "http://vps366535.ovh.net/api/eleves/list/"				//début des différentes routes pour acceder
		static let entreprisesList = "http://vps366535.ovh.net/api/entreprises/list/"	// a la base de données
		static let promotionsList = "http://vps366535.ovh.net/api/promotions/list/"
		static let relationsList = "http://vps366535.ovh.net/api/relations/list/"
	}
	private let key = "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
	
	func loadDataSource(dataSource: DataSource)->[Any]{
		
		var entreprises = getEntreprises()
		var eleves = getEleves()
		
		addRelation(eleves: &eleves, entreprises: &entreprises)
		
		if dataSource.typeData == .ELEVE  {
			
			var arr = [Eleve]()
			
			for (_, value) in eleves {
				arr.append(value)
				
			}
			
			return arr
			
			
		}
		if dataSource.typeData == .ENTREPRISE{
		var arr = [Entreprise]()
			
			for (_, value) in entreprises {
				arr.append(value)
			}
			
			return arr
			
		}
		
		return []
	}
	
	private func getEntreprises()->([Int:Entreprise]){
		
		var dict = [Int:Entreprise]()
		if let url = URL(string: URLS.entreprisesList + key) {
			if let data = try? Data(contentsOf: url) {
				let json = JSON(data: data)
				
				
				if json["success"].intValue == 1 {
					for result in json["body"].arrayValue {
						let entreprise = Entreprise(json: result)
						dict.updateValue(entreprise, forKey: entreprise.id)
					}
				}
			}
		}
		
		return dict
	}
	
	private func getEleves()->([Int:Eleve]){
		
		var dict = [Int:Eleve]()
		if let url = URL(string: URLS.elevesList + key) {
			if let data = try? Data(contentsOf: url) {
				let json = JSON(data: data)
				
				
				if json["success"].intValue == 1 {
					for result in json["body"].arrayValue {
						let eleve = Eleve(json: result)
						dict.updateValue(eleve, forKey: eleve.id)
					}
				}
			}
		}
		
		return dict
	}
	
	private func addRelation(eleves: inout [Int:Eleve], entreprises: inout [Int:Entreprise]){
		if let url = URL(string: URLS.relationsList + key) {
			if let data = try? Data(contentsOf: url) {
				let json = JSON(data: data)
				
				if json["success"].intValue == 1 {
					for result in json["body"].arrayValue {
						
						let idEl = result["ideleve"].intValue
						let idEn = result["identreprise"].intValue
						
						
						eleves[idEl]?.entreprises.append(entreprises[idEn]!)
						entreprises[idEn]?.eleves.append(eleves[idEl]!)
						//ajout de l'eleve dans l'entreprises et de  l'entreprises dans l'eleve si ils sont liés dans la table relation
					}
				}
			}
		}
	}
}
