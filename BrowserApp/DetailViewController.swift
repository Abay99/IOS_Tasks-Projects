//
//  DetailViewController.swift
//  BrowserApp
//
//  Created by Abai Kalikov on 2/20/18.
//  Copyright © 2018 abai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var myWebView: UIWebView!
    

    var urlAdress: String = String()
    var isFavourite: Bool = Bool()
    var selectedIndex: Int = Int()
    var my_controller: MasterViewController!
    var num: Int = 0
    var selectedSegment: Int = 0
    func changecolor() {
        
        if num == 0{
            self.navigationController?.navigationBar.backgroundColor = UIColor.yellow
        } else {
            self.navigationController?.navigationBar.backgroundColor = nil
        }
        
        
    }
    
    @objc func tap() {
        
        my_controller.changeFavourite(selectedIndex)
        if selectedSegment == 1{
            my_controller.refreshTable()
            my_controller.myTable.reloadData()
        }
        changecolor()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if isFavourite{
            self.navigationController?.navigationBar.backgroundColor = UIColor.yellow
            num = 1
        }else {
            self.navigationController?.navigationBar.backgroundColor = nil
            num = 0
        }
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.numberOfTapsRequired = 3
        view.addGestureRecognizer(tapGesture)
        
        
        if let url = URL(string: urlAdress){
            let request = URLRequest(url: url)
            myWebView.loadRequest(request)
        }
        

        
        // Do any additional setup after loading the view.
    }

}
