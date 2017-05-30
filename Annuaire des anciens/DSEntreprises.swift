//
//  Entreprises.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON
class DSEntreprises: DataSource {
	
	override var datas: [Any]{
		return entreprises
	}
    
    var entreprises: [Entreprise] = []
    
    static var entreprisesList = [Int:Entreprise]()
    
    var entreprisesFiltered: [Entreprise] = []
	override var typeData: type {return .ENTREPRISE}
	
    override var count: Int { return entreprises.count }
	
	
	override func setDatas(datasLoaded: [Any]) {
		entreprises = datasLoaded as! [Entreprise]
	}
	
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        var i = 0
        for key in makeSection().keys.sorted() {
            if i == indexPath.section {
                cell.textLabel?.text = makeSection()[key]![indexPath.row]
            }
            i += 1
        }
//        cell.textLabel?.text = entreprises[indexPath.row].nom
    }
    
    override func makeSection() -> [String:[String]] {
        
        let dataForSection: [Entreprise] = entreprisesFiltered.isEmpty ? entreprises : entreprisesFiltered
        var dictForTitlesAndRow = [String:[String]]()
        
        for entreprise in dataForSection {
            if dictForTitlesAndRow.keys.contains(entreprise.nom[0].uppercased()) {
                dictForTitlesAndRow[entreprise.nom[0].uppercased()]!.append(entreprise.nom)
            }
            else {
                dictForTitlesAndRow.updateValue([entreprise.nom], forKey: entreprise.nom[0].uppercased())
            }
        }
        return dictForTitlesAndRow
    }
	
	override func loadDatas() {
		let webservice = WebService()
		self.setDatas(datasLoaded: webservice.loadDataSource(dataSource: self))
		entreprises = entreprises.sorted(by: {$0.nom < $1.nom})
	}
	
	override func prepareForSegue(dataSource: DataSource, segue: UIStoryboardSegue, tableView: UITableView) {
		if let dest = segue.destination as? ShowEntrepriseViewController {
			let dsEntreprise = dataSource as! DSEntreprises
			var countElement = 0
			for i in 0..<tableView.indexPathForSelectedRow!.section{
				let countRowInSection = tableView.numberOfRows(inSection: i)
				countElement += countRowInSection
			}
			let entreprise = dsEntreprise.entreprises[countElement + tableView.indexPathForSelectedRow!.row]
			
			dest.entreprise = entreprise
		}
	}
	
	override func filter(dataSource: DataSource, searchText: String) {
		let dsEntreprise = dataSource as! DSEntreprises
		let cleanSearchText = searchText.lowercased()
		
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
}
