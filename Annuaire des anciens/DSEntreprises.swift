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
    var entreprisesFiltered: [Entreprise] = []
    override var typeData: DataSource.type{return DataSource.type.ENTREPRISE}
    
    override var count: Int { return entreprises.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = entreprises[indexPath.row].nom
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
    }
}
