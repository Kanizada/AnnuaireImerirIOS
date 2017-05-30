//
//  Eleves.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

// cette extension ajoute au type String deja défini la possibilité d'utiliser subscript et donc recupérer un String qui est a l'index donné, ou  dans l'intervalle donné ( String[1] donnera la 2eme lettre de la String par exemple)
extension String {
	
	var length: Int {
		return self.characters.count
	}
	
	subscript (i: Int) -> String {
		return self[Range(i ..< i + 1)]
	}
	
	func substring(from: Int) -> String {
		return self[Range(min(from, length) ..< length)]
	}
	
	func substring(to: Int) -> String {
		return self[Range(0 ..< max(0, to))]
	}
	
	subscript (r: Range<Int>) -> String {
		let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
		                                    upper: min(length, max(0, r.upperBound))))
		let start = index(startIndex, offsetBy: range.lowerBound)
		let end = index(start, offsetBy: range.upperBound - range.lowerBound)
		return self[Range(start ..< end)]
	}
	
}

//struct Section {
//	var title : String
//	var eleves : [String]
//	
//	init() {
//		self.title = title
//		self.eleves = eleves
//	}
//}

class DSEleves: DataSource{
	
    var eleves: [Eleve] = []
    var elevesFiltered: [Eleve] = []
	
	override var datas : [Any] {return eleves}
    override var typeData: type{return .ELEVE}
    override var count: Int { return elevesFiltered.isEmpty ? eleves.count : elevesFiltered.count}
	
	override func setDatas(datasLoaded: [Any]) {
		eleves = datasLoaded as! [Eleve]
	}
	
	//fonction qui est appelée lors de l'affichage des données dans le cellForRowAt dans TableViewController
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        //cell.textLabel?.text = eleves[indexPath.row].nom
		var i = 0
		for key in makeSection().keys.sorted() {
			if i == indexPath.section {
				cell.textLabel?.text = makeSection()[key]![indexPath.row]
			}
			i += 1
		}
//        cell.textLabel?.text = elevesFiltered.isEmpty ? eleves[indexPath.row].nom : elevesFiltered[indexPath.row].nom
    }
	
	// fonction qui permet de récuperer les eleves ainsi que la premiere lettre de leurs noms dans un dictionnaire de type String:[String] , avec ceci on peut créer l'index ainsi que les sections dans les TablesViews
	override func makeSection() -> [String:[String]] {
		
		let dataForSection: [Eleve] = elevesFiltered.isEmpty ? eleves : elevesFiltered
		var dictForTitlesAndRow = [String:[String]]()
		
		for eleve in dataForSection {
			if dictForTitlesAndRow.keys.contains(eleve.nom[0].uppercased()) {
				dictForTitlesAndRow[eleve.nom[0].uppercased()]!.append(eleve.nom)
			}
			else {
				dictForTitlesAndRow.updateValue([eleve.nom], forKey: eleve.nom[0].uppercased())
			}
		}
		return dictForTitlesAndRow
	}
	
	override func loadDatas() {
		let webservice = WebService()
		self.setDatas(datasLoaded: webservice.loadDataSource(dataSource: self))
		eleves = eleves.sorted(by: {$0.nom < $1.nom})
	}
	
	override func prepareForSegue(dataSource: DataSource, segue: UIStoryboardSegue, tableView: UITableView) {
		if let dest = segue.destination as? ShowEleveViewController {
			let dsEleves = dataSource as! DSEleves
			var countElement = 0
			for i in 0..<tableView.indexPathForSelectedRow!.section {
				let countRowInSection = tableView.numberOfRows(inSection: i)
				countElement += countRowInSection
			}
			let eleve = dsEleves.eleves[countElement + tableView.indexPathForSelectedRow!.row]
			dest.eleve = eleve
		}
	}
	
	override func filter(dataSource: DataSource, searchText: String) {
		let dsEleve = dataSource as! DSEleves
		let cleanSearchText = searchText.lowercased()
		
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
	
	static let sharedEleve = DSEleves()
	
}
