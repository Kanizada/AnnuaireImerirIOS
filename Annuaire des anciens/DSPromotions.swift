//
//  Promotions.swift
//  Annuaire des anciens
//
//  Created by Student on 07/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class DSPromotions: DataSource {
    
    var promotions: [Promotion] = [Promotion()]
    
    func _init() {
        self.promotions.append(Promotion())
        self.count = promotions.count
    }
    
    override func layout(cell: UITableViewCell , indexPath: IndexPath) {
        cell.textLabel?.text = promotions[indexPath.row].nom
    }
    
}
