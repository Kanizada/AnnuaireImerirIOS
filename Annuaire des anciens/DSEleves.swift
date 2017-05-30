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
    
    override var url: String { return URLS.elevesList }
    
    var eleves: [Eleve] = []
    
    static var elevesList = [Int:Eleve]()
    
    var elevesFiltered: [Eleve] = []
    override var typeData: DataSource.type{return DataSource.type.ELEVE}
    
    override var count: Int { return elevesFiltered.isEmpty ? eleves.count : elevesFiltered.count}
	
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
	
	
	//fonction qui permet de remplir un dictionnaire statique avec les id des eleves trouvés sur la base de donnée avec comme value l'eleve et comme clé son ID
    static func loadList() {
        let urlStringEleve = URLS.elevesList  + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
        
        if let url = URL(string: urlStringEleve) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
					if DSEleves.elevesList.isEmpty {
						for result in json["body"].arrayValue {
							let newEleve = Eleve()
							newEleve.construct(datas: result)
							DSEleves.elevesList.updateValue(newEleve, forKey: newEleve.id)
						}
						
					}
                }
            }
        }
    }
	
	//fonction qui appelle la fonction parseData pour parser les eleves de la base de donnée
    override func loadDatas() {
        let urlStringEleve = self.url + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"   // fin de l'url pour se connecter a la base de donnée
        
        if let url = URL(string: urlStringEleve) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
                    self.parseDatas(json: json)
                }
            }
        }
    }
	
	//fonction qui pour chaque eleve, rempli les données comme le nom ou le prenom et les trie alphabetiquement
    override func parseDatas(json: JSON){
        for result in json["body"].arrayValue {
            let neweleve = Eleve()
            neweleve.construct(datas: result)
            eleves.append(neweleve)
        }
        eleves.sort(by: {$0.nom < $1.nom})
    }
	
	static let sharedEleve = DSEleves()
    
}
