//
//  DataSourceProtocol.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataSource: NSObject {
    
    var url: String { return "" }
    var count: Int { return 0 }
    
    func layout(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
    func loadDatas() {}
    
    func parseDatas(json: JSON) {}
	
}
