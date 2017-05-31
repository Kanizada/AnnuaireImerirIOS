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
        switch section {
        case 0:
            return "Informations"
        case 1:
            return "Eleves"
        default:
            return "#@*!"
        }
	}
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.entrepriseOnTable[section].count
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = self.sectionTitle[indexPath.row]
            cell.detailTextLabel?.text = self.entrepriseOnTable[indexPath.section][indexPath.row]
        } else {
            cell.textLabel?.text = self.entrepriseOnTable[indexPath.section][indexPath.row]
            cell.detailTextLabel?.text = ""
        }
        return cell
    }

}
