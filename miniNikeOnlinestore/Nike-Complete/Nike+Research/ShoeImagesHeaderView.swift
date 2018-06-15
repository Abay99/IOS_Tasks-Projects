//
//  ShoeImagesHeaderView.swift
//  Nike+Research
//
//  Created by Abai Kalikov on 2/14/18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit

class ShoeImagesHeaderView: UIView
{
    @IBOutlet weak var pageControl: UIPageControl!
}

extension ShoeImagesHeaderView : ShoeImagesPageViewControllerDelegate
{
    func setupPageController(numberOfPages: Int)
    {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int)
    {
        pageControl.currentPage = index
    }
}











