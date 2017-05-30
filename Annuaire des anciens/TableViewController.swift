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
	static let elevesList = "http://vps366535.ovh.net/api/eleves/list/"				//début des différentes routes pour acceder
    static let entreprisesList = "http://vps366535.ovh.net/api/entreprises/list/"	// a la base de données
    static let promotionsList = "http://vps366535.ovh.net/api/promotions/list/"
    static let relationsList = "http://vps366535.ovh.net/api/relations/list/"
}

class TableViewController: UITableViewController, UISearchBarDelegate {
	
    static var relationed = false
    
	@IBOutlet var dataSource: DataSource!
    
    @IBOutlet weak var entrepriseSearchBar: UISearchBar!
    @IBOutlet weak var eleveSearchBar: UISearchBar!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        DSEleves.loadList()
        DSEntreprises.loadList()
		
		self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
		dataSource.loadDatas()
        self.loadDatas()

        if (dataSource.typeData == DataSource.type.ENTREPRISE) {	   // definition du type de datasource selon ou on se trouve
            self.entrepriseSearchBar.delegate = self
        }
        else if (dataSource.typeData == DataSource.type.ELEVE) {
            self.eleveSearchBar.delegate = self
        }
	}
	
	func loadDatas(){								//fonction qui permet de charger les données dans l'application
		
        if TableViewController.relationed == false { // test du bool pour éviter les redondances
            let urlStringRelations = URLS.relationsList  + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"   //url de la base de donnée de la table de relation
            
            if let url = URL(string: urlStringRelations) {
                if let data = try? Data(contentsOf: url) {
                    let json = JSON(data: data)
                    
                    if json["success"].intValue == 1 {
                        for result in json["body"].arrayValue {
                            
                            let idEl = result["ideleve"].intValue
                            let idEn = result["identreprise"].intValue
                            
                            
                            DSEleves.elevesList[idEl]?.entreprises.append(DSEntreprises.entreprisesList[idEn]!)
                            DSEntreprises.entreprisesList[idEn]?.eleves.append(DSEleves.elevesList[idEl]!)
							//ajout de l'eleve dans l'entreprises et de  l'entreprises dans l'eleve si ils sont liés dans la table relation
                        }
                    }
                }
            }
            TableViewController.relationed = true     //bool pour éviter de refaire le traitement
        }
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
															//appel de la fonction définie dans DSEleves, qui permet l'affichage
		dataSource.layout(cell: cell, indexPath: indexPath)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellEntreprise", for: indexPath)
		
		//appel de la fonction définie dans DSEntreprises, qui permet l'affichage
		dataSource.layout(cell: cell, indexPath: indexPath)
		return cell
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.makeSection().count
	}
	
	// Création de l'index sur le coté, contenant uniquement les lettres des eleves présents
	override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		var data: [String] = []
		for key in dataSource.makeSection().keys {
			data.append(key)
		}
		return data.sorted()
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		var i = 0
		for key in dataSource.makeSection().keys.sorted() {
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
		for key in dataSource.makeSection().keys.sorted() {
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
	//envoie des id dans le prochain TableViewController, permettant de récuperer les données dans le Controller
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  		let mySender = sender as! UITableViewCell
		if(mySender.reuseIdentifier == "cell"){
			if let dest = segue.destination as? ShowEleveViewController {
				let dsEleves = dataSource as! DSEleves
                var countElement = 0
                for i in 0..<tableView.indexPathForSelectedRow!.section {
                    let countRowInSection = tableView.numberOfRows(inSection: i)
                    countElement += countRowInSection
                }
				let eleve = dsEleves.eleves[countElement + tableView.indexPathForSelectedRow!.row]
                dest.eleveid = eleve.id
			}
		}else if(mySender.reuseIdentifier == "cellEntreprise"){
			if let dest = segue.destination as? ShowEntrepriseViewController {
				let dsEntreprise = dataSource as! DSEntreprises
                var countElement = 0
                for i in 0..<tableView.indexPathForSelectedRow!.section{
                    let countRowInSection = tableView.numberOfRows(inSection: i)
                    countElement += countRowInSection
                }
				
				
				
				let entreprise = dsEntreprise.entreprises[countElement + tableView.indexPathForSelectedRow!.row]
				
				dest.entrepriseid = entreprise.id
			}
		}
	}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let cleanSearchText = searchText.lowercased()
		
        if (dataSource.typeData == DataSource.type.ELEVE) {
            let dsEleve = dataSource as! DSEleves
            
            if (searchText != "") {						//Si un texte est entré
                dsEleve.elevesFiltered = []				//on clean le tableau des données filtrées
                for eleve: Eleve in dsEleve.eleves {	//rajout des données contenant le texte saisi dans les données filtrées
                    if eleve.nom.lowercased().contains(cleanSearchText) {
                        dsEleve.elevesFiltered.append(eleve)
                    }
                }
            }
            else {										//Sinon on clean les données filtrées
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
        
        tableView.reloadData()		//refresh tableView
    }
	
}


