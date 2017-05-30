//
//  DataSourceProtocol.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON


class DataSource: NSObject {			// Cette classe est la base des 2 datasources qui seront utilisé dans l'application
										// chaque variable et chaque fonction déclarées ici pourra etre utiliser dans les datasources
    
    var url: String { return "" }
    var count: Int { return 0 }
    var typeData: type {return type.NOT_INIT}
	var datas: [Any] {return []}
	var datasFiltered: [Any] {return []}
	
	func setDatas(datasLoaded: [Any]){}
    
    func layout(cell: UITableViewCell, indexPath: IndexPath) {}
	
	func prepareForSegue(dataSource: DataSource, segue: UIStoryboardSegue, tableView: UITableView){}
	
    func loadDatas() {}
    
    func parseDatas(json: JSON) {}
	
	func makeSection() -> Dictionary<String, [String]> {return [:]}
	
	func filter(dataSource: DataSource, searchText: String){}
	
}
