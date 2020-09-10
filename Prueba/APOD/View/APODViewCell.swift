//
//  APODViewCell.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/9/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import UIKit
import Kingfisher

class APODViewCell: UITableViewCell {

    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var apodTitle: UILabel!
    @IBOutlet weak var apodAuthor: UILabel!
    
    var apod: APOD? {
        didSet {
            self.configureCell()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailsView.addCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// set apod info 
    func configureCell() {
        if let apod = apod {
            apodTitle.text = apod.title
            apodAuthor.text = "\(apod.date) | \(apod.copyright ?? "-")"
            apodImage.kf.setImage(with: apod.url, placeholder: UIImage(named: "image-placeholder"), options: [.transition(.fade(0.2))])
        }
    }

}
