//
//  DetailViewController.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistYearLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var creditsLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var artWork:Art?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text       = artWork!.title
        artistYearLbl.text  = "Door \(artWork!.creator) - \(artWork!.date)"
        descriptionLbl.text = artWork!.description
        creditsLbl.text     = artWork!.credit
        
        // Load image from URL
        do {
            let rawImage = try Data.init(contentsOf: artWork!.imagefile)
            let image = UIImage(data: rawImage)
            imageView.image = image
        } catch {
            print(error.localizedDescription)
        }

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
