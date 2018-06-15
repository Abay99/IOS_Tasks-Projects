//
//  EditViewController.swift
//  MapTask
//
//  Created by Abai Kalikov on 28.03.18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit
import Cartography

class EditViewController: UIViewController {
    var my_title = "Almaty"
    var my_subtitle = "Something"
    lazy var titleTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 5 / 736 * UIScreen.main.bounds.height
        tf.text = my_title
        tf.backgroundColor = .white
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    lazy var subtitleTF: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 5 / 736 * UIScreen.main.bounds.height
        tf.text = my_subtitle
        tf.backgroundColor = .white
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 173 / 255, green: 207 / 255, blue: 246 / 255, alpha: 1)
        self.title = "Edit"
        setupViews()
        setupConstraints()
        barButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func setupViews(){
        view.addSubview(titleTF)
        view.addSubview(subtitleTF)
    }
    func setupConstraints(){
        constrain(titleTF, view){ tf, vw in
            tf.top == vw.top + 200
            tf.centerX == vw.centerX
            tf.width == vw.width / 2
            tf.height == 30
        }
        constrain(subtitleTF, titleTF, view){ sf, tf, vw in
            sf.top == tf.bottom + 35
            sf.centerX == vw.centerX
            sf.width == vw.width / 2
            sf.height == 30
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func barButton(){
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonPressed))
        navigationItem.rightBarButtonItem  = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.compact)
        self.navigationController?.navigationBar.alpha = 0.8
        button.tintColor = UIColor.init(red: 75/255, green: 135/255, blue: 190/255, alpha: 1)
    }
    
    @objc func buttonPressed(){
        print("!!!!")
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
