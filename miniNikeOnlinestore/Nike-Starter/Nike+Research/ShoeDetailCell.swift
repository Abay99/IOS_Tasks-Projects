//
//  ShoeDetailCell.swift
//  Nike+Research
//
//  Created by Abai Kalikov on 2/14/18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit

class ShoeDetailCell : UITableViewCell
{
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoeDescriptionLabel: UILabel!
    
    var shoe: Shoe! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        shoeNameLabel.text = shoe.name
        shoeDescriptionLabel.text = shoe.description
    }
}
