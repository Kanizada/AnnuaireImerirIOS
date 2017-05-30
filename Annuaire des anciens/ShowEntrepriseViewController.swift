//
//  ShowEleveViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 13/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ShowEntrepriseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var dataSource: DataSource!
	@IBOutlet weak var nomLabel : UILabel!
	@IBOutlet weak var mailLabel : UILabel!
	@IBOutlet weak var fixeLabel : UILabel!
	@IBOutlet weak var webLabel : UILabel!
	@IBOutlet weak var adresseLabel : UILabel!
	@IBOutlet weak var villeLabel: UILabel!
	@IBOutlet weak var postalLabel : UILabel!
	@IBOutlet weak var relationTable: UITableView!
	
	
	var entreprise : Entreprise!
	var elevesLies: [Eleve] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(false, animated: false)
		elevesLies = entreprise.eleves
		
		nomLabel.text = entreprise.nom
		mailLabel.text = entreprise.email
		fixeLabel.text = entreprise.telephone
		webLabel.text = entreprise.site_web
		adresseLabel.text = entreprise.adresse
		villeLabel.text = entreprise.ville
		postalLabel.text = entreprise.code_postal
		
		relationTable.delegate = self
		relationTable.dataSource = self
		
		
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return elevesLies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetailEntreprise", for: indexPath)
		
		cell.textLabel?.text = elevesLies[indexPath.row].nom
		
		return cell
	}
	
	
	
}
