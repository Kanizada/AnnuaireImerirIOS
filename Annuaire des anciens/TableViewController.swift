//
//  ViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController, UISearchBarDelegate {
	
    static var relationed = false
    
	@IBOutlet var dataSource: DataSource!
    @IBOutlet weak var searchBar: UISearchBar!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
		dataSource.loadDatas()
		self.searchBar.delegate = self
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
															//appel de la fonction définie dans DSEleves, qui permet l'affichage
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
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		dataSource.prepareForSegue(dataSource: dataSource, segue: segue, tableView: tableView)
	}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.filter(dataSource: dataSource, searchText: searchText)
        tableView.reloadData()		//refresh tableView
    }
}


