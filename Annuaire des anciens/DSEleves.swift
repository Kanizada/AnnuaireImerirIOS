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
    
    override var count: Int { return eleves.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = eleves[indexPath.row].nom
    }
    
    override func loadDatas() {
        let urlStringEleve = self.url + "?key=devTmpkey"
        
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
    }
	
	static let sharedEleve = DSEleves()
    
}
