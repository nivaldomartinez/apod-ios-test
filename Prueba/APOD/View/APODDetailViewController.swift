//
//  APODDetailViewController.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/10/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import UIKit
import Kingfisher

class APODDetailViewController: UIViewController {
    
    var apod: APOD?
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var contentDetailView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var explanationText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentDetailView.addCornerRadius(corners: [.topLeft, .topRight])
        
        apodImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapImage)))
        
        populateApod()
        
    }
    
    /// populate apod info 
    func populateApod() {
        if let apod = apod {
            setHDImage()
            titleLabel.text = apod.title
            subtitleLabel.text = getSubtitleText()
            explanationText.text = apod.explanation
        }
        
    }
    
    /// this returns a diferent subtitle text depends on copyright
    func getSubtitleText() -> String {
        if let copyright = apod?.copyright {
            return "created by \(copyright) on \(apod?.date ?? "")"
        }
        
        return "created on \(apod?.date ?? "")"
    }
    
    /// this runs when the user touches the image to show or hide the content view
    @objc func onTapImage() {
        let isCollapsed = contentViewHeight.constant == 0
        contentViewHeight.constant =  isCollapsed ? 310 : 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    /// this sets hd image if is possible
    private func setHDImage() {
        activityIndicator.startAnimating()
        if let apod = apod {
            apodImage.kf.setImage(with: apod.hdurl ?? apod.url, options: [.transition(.fade(0.3))]) { (_) in
                self.activityIndicator.stopAnimating()
            }
        }
    }

}
