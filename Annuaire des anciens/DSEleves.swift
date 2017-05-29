//
//  Eleves.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

class DSEleves: DataSource{
    
    override var url: String { return URLS.elevesList }
    
    var eleves: [Eleve] = []
    var elevesFiltered: [Eleve] = []
    override var typeData: DataSource.type{return DataSource.type.ELEVE}
    
    override var count: Int { return elevesFiltered.isEmpty ? eleves.count : elevesFiltered.count}
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        //cell.textLabel?.text = eleves[indexPath.row].nom
        cell.textLabel?.text = elevesFiltered.isEmpty ? eleves[indexPath.row].nom : elevesFiltered[indexPath.row].nom
    }
    
    override func loadDatas() {
        let urlStringEleve = self.url + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
        
        if let url = URL(string: urlStringEleve) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
                    self.parseDatas(json: json)
                }
            }
        }
    }
    
    override func parseDatas(json: JSON){
        for result in json["body"].arrayValue {
            let neweleve = Eleve()
            neweleve.construct(datas: result)
            eleves.append(neweleve)
        }
        eleves.sort(by: {$0.nom < $1.nom})
    }
	
	static let sharedEleve = DSEleves()
    
}
