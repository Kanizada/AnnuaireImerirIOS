//
//  Eleves.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class DSEleves: DataSource{
    
    var eleves: [Eleve] = [Eleve(),Eleve()]
    
    override var count: Int { return eleves.count }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = eleves[indexPath.row].nom
    }
    
}
