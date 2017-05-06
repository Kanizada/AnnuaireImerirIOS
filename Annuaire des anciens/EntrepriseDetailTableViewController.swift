//
//  EntrepriseDetailTableViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 28/04/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class EntrepriseDetailTableViewController: UITableViewController {
	
	@IBOutlet var dataSource: DataSource!
	
	var entreprise : Entreprise!

	let sectionTitle = ["Nom de l'entreprise", "Adresse de l'entreprise","Code postal", "Téléphone de l'entreprise", "Email de l'entreprise"]
	var entrepriseOnTable : [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(false, animated: false)
		entrepriseOnTable = entreprise.getArray()
		
	}

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.sectionTitle[section]
	}
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sectionTitle.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.entrepriseOnTable[section].count
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entrepriseCell", for: indexPath)

		cell.textLabel?.text = self.entrepriseOnTable[indexPath.section][indexPath.row]

        return cell
    }

}
