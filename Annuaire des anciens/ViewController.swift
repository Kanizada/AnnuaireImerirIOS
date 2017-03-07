//
//  ViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 06/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var etudiantTableView: UITableView!
    @IBOutlet weak var entrepriseTableView: UITableView!
    @IBOutlet weak var promotionTableView: UITableView!
    

    var Eleves : [Eleve] = [Eleve(), Eleve(), Eleve(), Eleve()]
    var Entreprises : [Entreprise] = [Entreprise(), Entreprise(), Entreprise()]
    var Promotions : [Promotion] = [Promotion(), Promotion()]
    
    var currentDatas: [DataString] = []
    var currentCell : String = "cell1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if( etudiantTableView != nil ){
                currentDatas = Eleves
        }
        else if( entrepriseTableView != nil ) {
                currentDatas = Entreprises
        }
        else {
            currentDatas = Promotions
        }
        
        return currentDatas.count
        
    }

    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if( etudiantTableView != nil ){
            currentCell = "cell1"
        }
        else if( entrepriseTableView != nil ) {
            currentCell = "cell2"
        }
        else {
            currentCell = "cell3"
        }
        
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: currentCell, for: indexPath) as! TableViewCell
        
        cell.setTitle(curentCell: currentCell, text: currentDatas[indexPath.row].getString())
        return cell
    }
    

}

protocol DataString {
    
    func getString() -> String
    
}

