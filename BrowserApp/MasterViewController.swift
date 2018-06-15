//
//  MasterViewController.swift
//  BrowserApp
//
//  Created by Abai Kalikov on 2/20/18.
//  Copyright © 2018 abai. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var websites: [Websites] = Array()
    var showingTable: [Websites] = Array()

    
    @IBOutlet weak var myTable: UITableView!
    
    var text: String = String()
    
    @IBOutlet weak var mySegmentController: UISegmentedControl!
    
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        if mySegmentController.selectedSegmentIndex == 0{
            showingTable.removeAll()
            showingTable = websites
         
        }
        else{
           showingTable.removeAll()
            for element in websites {
                if element.isFavourite == true {
                    showingTable.append(element)
                }
            }
            
        }
      
        myTable.reloadData()
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return showingTable.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = showingTable[indexPath.row].websiteTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        

    }
 
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showSite"{
            
            var destination: DetailViewController!
            
            if let detailNavigationController = segue.destination as? UINavigationController{
                
                destination = detailNavigationController.topViewController as! DetailViewController
                
                destination.urlAdress = showingTable[(myTable.indexPathForSelectedRow?.row)!].websiteAdress
                destination.self.title = showingTable[(myTable.indexPathForSelectedRow?.row)!].websiteTitle
                destination.isFavourite = showingTable[(myTable.indexPathForSelectedRow?.row)!].isFavourite
                destination.selectedIndex = (myTable.indexPathForSelectedRow?.row)!
                destination.selectedSegment = mySegmentController.selectedSegmentIndex
                destination.my_controller = self
                
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        websites.append(Websites("Instagram", "https://instagram.com", false))
        websites.append(Websites("VK", "https://vk.com", false))
        showingTable = websites
    }
    
    
    func changeFavourite(_ index: Int) {
        print(index)
        
        if showingTable[index].isFavourite == true{
            showingTable[index].isFavourite = false
            
        } else {
            
            showingTable[index].isFavourite = true
        }
        
        if mySegmentController.selectedSegmentIndex == 1{
            showingTable.removeAll()
            for element in websites {
                print (element.isFavourite)
                if element.isFavourite == true {
                    
                    showingTable.append(element)
                }
            }

        }

        myTable.reloadData()
    }
    
   
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add Website", message: "Fill all the fields", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (titleTextField : UITextField) -> Void in
            titleTextField.placeholder = "Enter title"
            self.text = titleTextField.text!
            
        }
        
        
        alertController.addTextField { (urlTextField : UITextField) -> Void in
            urlTextField.placeholder = "Enter Url"
        }
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            
            let titleField = alertController.textFields![0] as UITextField
            let urlField = alertController.textFields![1] as UITextField
            
            self.websites.append(Websites(titleField.text!, "https://\(urlField.text!)", false))
            self.showingTable = self.websites
            self.myTable.reloadData()
        }
        
        
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func refreshTable() {
        
        showingTable.removeAll()
        for element in websites {
            if element.isFavourite == true {
                showingTable.append(element)
            }
        }
        
    }
    
    }
