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
	static let elevesList = "http://vps366535.ovh.net/api/eleves/list/"
	static let entreprisesList = "http://vps366535.ovh.net/api/entreprises/list/"
	static let promotionsList = "http://vps366535.ovh.net/api/promotions/list/"
}

class TableViewController: UITableViewController, UISearchBarDelegate {
	
	
	@IBOutlet var dataSource: DataSource!
    
    @IBOutlet weak var entrepriseSearchBar: UISearchBar!
    @IBOutlet weak var eleveSearchBar: UISearchBar!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
		dataSource.loadDatas()

        if (dataSource.typeData == DataSource.type.ENTREPRISE) {
            self.entrepriseSearchBar.delegate = self
        }
        else if (dataSource.typeData == DataSource.type.ELEVE) {
            self.eleveSearchBar.delegate = self
        }
	}
	
	func loadDatas(){
		dataSource.loadDatas()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
	}
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if(self.tabBarController?.selectedIndex == 0){
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		dataSource.layout(cell: cell, indexPath: indexPath)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellEntreprise", for: indexPath)
		
		dataSource.layout(cell: cell, indexPath: indexPath)
		return cell
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.makeSection().count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		var i = 0
		for key in dataSource.makeSection().keys {
			if i == section {
				return key
			}
			i += 1
		}
		return "#@*!"
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var i = 0;
		var currentKey:String = "default"
		for key in dataSource.makeSection().keys {
			if i == section {
				currentKey = key
			}
			i += 1
		}
		guard let count = dataSource.makeSection()[currentKey]?.count  else {
			fatalError()
		}
		return count
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let mySender = sender as! UITableViewCell
		if(mySender.reuseIdentifier == "cell"){
			if let dest = segue.destination as? EleveDetailTableViewController {
				let dsEleves = dataSource as! DSEleves
				let eleve = dsEleves.eleves[tableView.indexPathForSelectedRow!.row]
				dest.eleve = eleve
			}
		}else if(mySender.reuseIdentifier == "cellEntreprise"){
			if let dest = segue.destination as? EntrepriseDetailTableViewController {
				let dsEntreprise = dataSource as! DSEntreprises
				let entreprise = dsEntreprise.entreprises[tableView.indexPathForSelectedRow!.row]
				dest.entreprise = entreprise
			}
		}
	}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let cleanSearchText = searchText.lowercased()
        
        if (dataSource.typeData == DataSource.type.ELEVE) {
            let dsEleve = dataSource as! DSEleves
            
            if (searchText != "") {
                dsEleve.elevesFiltered = []
                for eleve: Eleve in dsEleve.eleves {
                    if eleve.nom.lowercased().contains(cleanSearchText) {
                        dsEleve.elevesFiltered.append(eleve)
                    }
                }
            }
            else {
                dsEleve.elevesFiltered = []
            }
        }
        else if (dataSource.typeData == DataSource.type.ENTREPRISE) {
            let dsEntreprise = dataSource as! DSEntreprises
            
            if (searchText != "") {
                dsEntreprise.entreprisesFiltered = []
                for entreprise: Entreprise in dsEntreprise.entreprises {
                    if entreprise.nom.lowercased().contains(cleanSearchText) {
                        dsEntreprise.entreprisesFiltered.append(entreprise)
                    }
                }
            }
            else {
                dsEntreprise.entreprisesFiltered = []
            }
        }
        
        tableView.reloadData()
    }
	
    
	/*func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	if let dest = segue.destination as? EntrepriseDetailTableViewController {
	let dsEntreprise = dataSource as! DSEntreprises
	let entreprise = DSEntreprises.entreprises[tableView.indexPathForSelectedRow!.row]
	dest.itemNom = entreprise
	}
	
	
	}*/
}


