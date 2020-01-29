//
//  ArtListViewController.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import UIKit

class ArtListViewController: UIViewController {

    var art = [Art]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        art = DAO.sharedInstance.getAllArt()
        //print(art)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
