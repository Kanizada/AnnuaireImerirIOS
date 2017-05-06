//
//  ShowEleveViewController.swift
//  Annuaire des anciens
//
//  Created by Student on 13/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ShowDetailEleveViewController: UIViewController {

	@IBOutlet var dataSource: DataSource!
	@IBOutlet weak var AdresseLabel : UILabel!
	@IBOutlet weak var NomLabel: UILabel!
	@IBOutlet weak var TelLabel : UILabel!
	@IBOutlet weak var MailLabel : UILabel!
	@IBOutlet weak var FormationLabel : UILabel!
	@IBOutlet weak var EntrepriseLabel : UILabel!
	@IBOutlet weak var AdresseValeurLabel : UILabel!
	@IBOutlet weak var NomValeurLabel: UILabel!
	@IBOutlet weak var TelValeurLabel : UILabel!
	@IBOutlet weak var MailValeurLabel : UILabel!
	@IBOutlet weak var FormationValeurLabel : UILabel!
	@IBOutlet weak var EntrepriseValeurLabel : UILabel!
	@IBOutlet weak var DateInscriptionLabel : UILabel!
	@IBOutlet weak var DateInscriptionValeurLabel: UILabel!
	
	var eleve: Eleve!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(false, animated: false)
		
		AdresseValeurLabel.text = eleve.adresse
		NomValeurLabel.text = eleve.nom
		TelValeurLabel.text = eleve.telephone_perso
		MailValeurLabel.text = eleve.email
		
		//AdresseValeurLabel.text = "test"
	//	loadDatas()

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

