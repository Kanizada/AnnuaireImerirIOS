//
//  Eleves.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    var elevesFiltered: [Eleve] = []
    override var typeData: DataSource.type{return DataSource.type.ELEVE}
    
    override var count: Int { return elevesFiltered.isEmpty ? eleves.count : elevesFiltered.count}
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        //cell.textLabel?.text = eleves[indexPath.row].nom
		var i = 0
		for key in makeSection().keys {
			if i == indexPath.section {
				cell.textLabel?.text = makeSection()[key]![indexPath.row]
			}
			i += 1
		}
//        cell.textLabel?.text = elevesFiltered.isEmpty ? eleves[indexPath.row].nom : elevesFiltered[indexPath.row].nom
    }
	
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
	
//	override func makeSection() -> Dictionary<String, [String]> {
//		
//			let dataForSection: [Eleve] = elevesFiltered.isEmpty ? eleves : elevesFiltered
//			var dictForTitlesAndRow:[String:[String]] = [:]
//			
//			//if(elevesFiltered.isEmpty){
//			
//			for allEleve in dataForSection {
//				
//				let nameInMemori: String = allEleve.nom //)+""+allEleve.prenom)
//				let testValeurActuelle:Int = (value(forKey: nameInMemori[1]) != nil) ? 0 : 1
//				print(testValeurActuelle)
//				
//				if(testValeurActuelle == 0){
//					dictForTitlesAndRow.updateValue([nameInMemori], forKey: nameInMemori[1])
//					
//				} else if(testValeurActuelle == 1){
//					dictForTitlesAndRow[nameInMemori[1]]?.append(nameInMemori)
//				}
//				print(dictForTitlesAndRow)
//			}
//			
//			return dictForTitlesAndRow
//		}
	
    override func loadDatas() {
        let urlStringEleve = self.url + "cptYv2qNjDGHOZRjOmu5sy0gbzKp0ZWdpqbUsCILfos3nkncHShaqiqBSb1SbX6AnhvQUdCaC4e0pBd7tvhUNIvGTxz4vFFTXaJRol21qg1QSfXmKegyXLeQjNVOsAHpKrh9NjaeAc4sr1Obg4JeQY"
        
        if let url = URL(string: urlStringEleve) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["success"].intValue == 1 {
                    self.parseDatas(json: json)
                }
            }
        }
    }
    
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
