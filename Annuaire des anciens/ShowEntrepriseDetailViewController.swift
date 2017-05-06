//
//  ShowEntrepriseDetailViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 28/04/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ShowEntrepriseDetailViewController: UIViewController {
	
	@IBOutlet var dataSource: DataSource!
	
	@IBOutlet weak var AdresseLabel : UILabel!
	@IBOutlet weak var NomLabel: UILabel!
	@IBOutlet weak var TelLabel : UILabel!
	@IBOutlet weak var MailLabel : UILabel!
	
	@IBOutlet weak var AdresseValeurLabel : UILabel!
	@IBOutlet weak var NomValeurLabel: UILabel!
	@IBOutlet weak var TelValeurLabel : UILabel!
	@IBOutlet weak var MailValeurLabel : UILabel!


	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class EntrepriseTableView: UITableView{
	
	override func numberOfRows(inSection section: 5) -> Int {
		return 15
	}
	
	
}
