//
//  ShowEleveViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 13/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ShowEleveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet var dataSource: DataSource!
	@IBOutlet weak var nomLabel : UILabel!			//liste des labels pour afficher les données dans le détail élève
	@IBOutlet weak var prenomLabel: UILabel!
	@IBOutlet weak var mailLabel : UILabel!
	@IBOutlet weak var fixeLabel : UILabel!
	@IBOutlet weak var mobileLabel: UILabel!
	@IBOutlet weak var webLabel : UILabel!
	@IBOutlet weak var adresseLabel : UILabel!
	@IBOutlet weak var villeLabel: UILabel!
	@IBOutlet weak var postalLabel : UILabel!
	@IBOutlet weak var relationTable: UITableView!
	

	var eleveid : Int!
	var entrepriseLiees: [Entreprise] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(false, animated: false)
		
		let realEleve = DSEleves.elevesList[eleveid]!					// bind d'un eleve précis dans une constante
		entrepriseLiees = (DSEleves.elevesList[eleveid]?.entreprises)!	// bind de la liste des entreprises liées a cet eleve
		
		nomLabel.text = realEleve.nom									//bind de tous les divers labels d'affichage des données
		prenomLabel.text = realEleve.prenom
		mailLabel.text = realEleve.email
		fixeLabel.text = realEleve.telephone_fixe
		mobileLabel.text = realEleve.telephone_mobile
		webLabel.text = realEleve.site_web
		adresseLabel.text = realEleve.adresse
		villeLabel.text = realEleve.ville
		postalLabel.text = realEleve.code_postal
		
		relationTable.delegate = self
		relationTable.dataSource = self
		
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return entrepriseLiees.count										
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetailEleve", for: indexPath)
		
		cell.textLabel?.text = entrepriseLiees[indexPath.row].nom
		
		return cell
	}


	
}
