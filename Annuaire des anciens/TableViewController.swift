//
//  ViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    @IBOutlet var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        dataSource.layout(cell: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

