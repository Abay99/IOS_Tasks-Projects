//
//  SuggestionCollectionViewCell.swift
//  Nike+Research
//
//  Created by Abai Kalikov on 2/14/18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            self.imageView.image = image
            self.setNeedsLayout()
        }
        
    }
}
