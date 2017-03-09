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
    
    override var count: Int { return entreprises.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = entreprises[indexPath.row].nom
    }
    
    
    override func loadDatas() {
        
        let urlStringEleve = URLS.entreprisesList  + "?key=devTmpkey"
        
        if let url = URL(string: urlStringEleve) {
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
            let newentreprise = Entreprise()
            newentreprise.construct(datas: result)
            self.entreprises.append(newentreprise)
        }
    }
}
