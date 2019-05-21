//
//  ScrollVC.swift
//  Haberler
//
//  Created by ENES AKSOY on 19.05.2019.
//  Copyright © 2019 ENES AKSOY. All rights reserved.
//

import UIKit


class ScrollVC: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    weak var delegate: NewsListDelegate?
    
    public func configure() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognizerTapped(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gestureRecognizerTapped(_ sender: Any) {
        self.delegate?.newsTapped(imageUrl: self.urlLabel.text ?? "")
    }
    
    
    
}
