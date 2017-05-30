//
//  Entreprises.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON
class DSEntreprises: DataSource {
    
    override var url: String { return URLS.entreprisesList}
    
    var entreprises: [Entreprise] = []
    
    static var entreprisesList = [Int:Entreprise]()
    
    var entreprisesFiltered: [Entreprise] = []
    override var typeData: DataSource.type{return DataSource.type.ENTREPRISE}
    
    override var count: Int { return entreprises.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        var i = 0
        for key in makeSection().keys.sorted() {
            if i == indexPath.section {
                cell.textLabel?.text = makeSection()[key]![indexPath.row]
            }
            i += 1
        }
//        cell.textLabel?.text = entreprises[indexPath.row].nom
    }
    
    override func makeSection() -> [String:[String]] {
        
        let dataForSection: [Entreprise] = entreprisesFiltered.isEmpty ? entreprises : entreprisesFiltered
        var dictForTitlesAndRow = [String:[String]]()
        
        for entreprise in dataForSection {
            if dictForTitlesAndRow.keys.contains(entreprise.nom[0].uppercased()) {
                dictForTitlesAndRow[entreprise.nom[0].uppercased()]!.append(entreprise.nom)
            }
            else {
                dictForTitlesAndRow.updateValue([entreprise.nom], forKey: entreprise.nom[0].uppercased())
            }
        }
        return dictForTitlesAndRow
    }
    
    static func loadList() {
        let urlStringEntreprise = URLS.entreprisesList  + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
        
        if let url = URL(string: urlStringEntreprise) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
					if DSEntreprises.entreprisesList.isEmpty {
						for result in json["body"].arrayValue {
							let newEntreprise = Entreprise()
							newEntreprise.construct(datas: result)
							DSEntreprises.entreprisesList.updateValue(newEntreprise, forKey: newEntreprise.id)
						}
					}
                }
            }
        }
    }
	
    override func loadDatas() {
        
        let urlStringEntreprise = URLS.entreprisesList  + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
        
        if let url = URL(string: urlStringEntreprise) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
                    parseDatas(json: json)
                }
            }
        }
    }
    
    override func parseDatas(json: JSON) {
        for result in json["body"].arrayValue {
            let newEntreprise = Entreprise()
            newEntreprise.construct(datas: result)
            self.entreprises.append(newEntreprise)
        }
		entreprises.sort(by: {$0.nom < $1.nom})
    }
}
