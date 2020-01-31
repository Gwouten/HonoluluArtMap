//
//  ArtListViewController.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import UIKit

class ArtListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var art = [Art]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        art = DAO.sharedInstance.getAllArt()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return art.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let currentArt = art[indexPath.row]
        currentCell.textLabel!.text = currentArt.title
        currentCell.detailTextLabel!.text = currentArt.discipline
        return currentCell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToDetailSegue" {
            let selectedIndexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let selectedArt = art[selectedIndexPath!.row]
            let destination = segue.destination as! DetailViewController
            let newAnnotation = Annotation.init(
                creator: selectedArt.creator,
                date: selectedArt.date,
                description: selectedArt.desc,
                locationname: selectedArt.locationname,
                imagefile: selectedArt.imagefile,
                discipline: selectedArt.discipline,
                title: selectedArt.title,
                latitude: selectedArt.latitude,
                longitude: selectedArt.longitude,
                credit: selectedArt.credit
            )
            destination.artWork = newAnnotation
        }
    }

}
