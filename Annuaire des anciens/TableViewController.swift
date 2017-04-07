//
//  ViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

struct URLS {
    static let elevesList = "http://vps366535.ovh.net/eleves/list"
    static let entreprisesList = "http://vps366535.ovh.net/entreprises/list"
    static let promotionsList = "http://vps366535.ovh.net/promotions/list"
}

class TableViewController: UITableViewController {
    
    
    @IBOutlet var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        loadDatas()
        
    }
    
    func loadDatas(){
        dataSource.loadDatas()
    }
	


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
        dataSource.layout(cell: cell, indexPath: indexPath)
		
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? ShowDetailEleveViewController {
			let dsEleves = dataSource as! DSEleves
			let eleve = dsEleves.eleves[tableView.indexPathForSelectedRow!.row]
			dest.eleve = eleve
		}
	}
}


