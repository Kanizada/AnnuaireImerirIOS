//
//  Entreprises.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class DSEntreprises: DataSource {
    
    var entreprises: [Entreprise] = [Entreprise()]
    
    override var count: Int { return entreprises.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = entreprises[indexPath.row].nom
    }
    
}
