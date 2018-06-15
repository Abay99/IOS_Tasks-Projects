//
//  CellModel.swift
//  MapTask
//
//  Created by Abai Kalikov on 28.03.18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import Foundation
import Cartography

class CellModel: UITableViewCell{
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23 / 736 * UIScreen.main.bounds.height)
        return label
    }()
    lazy var subtitleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20 / 736 * UIScreen.main.bounds.height)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        constrain(titleLabel, self){ tl, s in
            tl.top == s.top + 10
            tl.left == s.left + 10
        }
        constrain(subtitleLabel, titleLabel, self){ sl, tl, s in
            sl.top == tl.top + 40
            sl.left == s.left + 10
        }
    }
}
