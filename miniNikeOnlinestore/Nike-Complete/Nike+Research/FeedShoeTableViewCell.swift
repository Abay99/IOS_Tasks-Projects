//
//  FeedShoeTableViewCell.swift
//  Nike+Research
//
//  Created by Abai Kalikov on 2/14/18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit

class FeedShoeTableViewCell : UITableViewCell
{
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    
    var shoe: Shoe! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        shoeImageView.image = shoe.images?.first
        shoeNameLabel.text = shoe.name
        if let price = shoe.price {
            shoePriceLabel.text = "$\(price)"
        } else {
            shoePriceLabel.text = ""
        }
    }
}
