//
//  ViewController.swift
//  MapTask
//
//  Created by Abai Kalikov on 28.03.18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import UIKit
import MapKit
import Cartography
import CoreData
class ViewController: UIViewController {
    
    var markedPlaces: [Place] = []
    
    lazy var mapView: MKMapView = {
        var mv =  MKMapView()
        mv.delegate = self
        return mv
    }()
    lazy var myView: UIView = {
        var mv = UIView()
        mv.backgroundColor = .white
        mv.alpha = 0.8
        return mv
    }()
    lazy var segmentedControll: UISegmentedControl = {
        var sc = UISegmentedControl(items: ["Standard", "Satellite", "Hybrid"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(typeChange), for: .valueChanged)
        sc.tintColor = .black
        return sc
    }()
    lazy var leftButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(prevLocation), for: .touchUpInside)
        return button
    }()
    lazy var rightButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(nextLocation), for: .touchUpInside)
        return button
    }()
    
//    lazy var listButton: UIBarButtonItem = {
//        var button = UIBarButtonItem()
//        button.title = "happy"
//        button.style = .done
//        button.action = #selector(butPress)
//        return button
//    }()
    lazy var tableViewList: UIView = {
        let tableViewList = UIView(frame: .zero)
        tableViewList.backgroundColor = .white
        tableViewList.alpha = 0.8
        tableViewList.isHidden = true
        return tableViewList
    }()
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.isHidden = true
        tableView.separatorStyle = .none
        return tableView
    }()
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableViewList.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
        setupGesture()
        setupTableView()
        // Do any additional setup after loading the view, typically from a nib.
        saveCoreData()
        barButton()
//        self.navigationItem.rightBarButtonItem = listButton
        
    }
    
    
    
    func setupGesture(){
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationAlert(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
    }
    
    @objc func addAnnotationAlert(longGesture: UIGestureRecognizer){
        print("hello mf")
        let touchPoint = longGesture.location(in: self.mapView)
        let wayCoords = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let alert = UIAlertController(title: "Add place", message: "Fill all the fields", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter subtitle"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            print("you have pressed the ok button")
            //            let touchPoint = longGesture.location(in: self.mapView)
            //            let wayCoords = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            //let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
            // myWaypoints.append(location)
            //            let wayAnnotation = MKPointAnnotation()
            //            wayAnnotation.coordinate = wayCoords
            //            wayAnnotation.title = alert.textFields![0].text
            //            wayAnnotation.subtitle = alert.textFields![1].text
            //            self.mapView.addAnnotation(wayAnnotation)
            // myAnnotations.append(location)
            let place = Place(context: PersistenceService.context)
            place.title = alert.textFields![0].text
            place.subtitle = alert.textFields![1].text
            place.latitude = wayCoords.latitude
            place.longitude = wayCoords.longitude
            PersistenceService.saveContext()
            self.markedPlaces.append(place)
            //self.mapView.removeAnnotations(self.mapView.annotations)
            //            for annotation in self.markedPlaces{
            //                let signLocation = CLLocationCoordinate2DMake(annotation.latitude, annotation.longitude)
            //                let an = MKPointAnnotation()
            //                an.coordinate = signLocation
            //                an.title = annotation.title
            //                an.subtitle = annotation.subtitle
            //                self.mapView.addAnnotation(an)
            //            }
            let signLocation = CLLocationCoordinate2DMake((self.markedPlaces.last?.latitude)!, (self.markedPlaces.last?.longitude)!)
            let an = MKPointAnnotation()
            an.coordinate = signLocation
            an.title = self.markedPlaces.last?.title
            an.subtitle = self.markedPlaces.last?.subtitle
            self.mapView.addAnnotation(an)
            self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(signLocation, 1000, 1000), animated: true)
            self.title = self.markedPlaces.last?.title
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func saveCoreData(){
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        do{
            let markedPlaces = try PersistenceService.context.fetch(fetchRequest)
            self.markedPlaces = markedPlaces
            self.mapView.removeAnnotations(self.mapView.annotations)
            for annotation in self.markedPlaces{
                let signLocation = CLLocationCoordinate2DMake(annotation.latitude, annotation.longitude)
                let an = MKPointAnnotation()
                an.coordinate = signLocation
                an.title = annotation.title
                an.subtitle = annotation.subtitle
                self.mapView.addAnnotation(an)
            }
        } catch{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupViews(){
   //     view.addSubview(tableView)
        view.addSubview(mapView)
        view.addSubview(myView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(tableViewList)
        view.addSubview(segmentedControll)
    }
    func setupConstrains(){
        constrain(mapView, view){ mv, vw in
            mv.edges == vw.edges
        }
        constrain(myView, view){ mv, vw in
            mv.bottom == vw.bottom
            mv.left == vw.left
            mv.right == vw.right
            mv.height == 100 / 736 * UIScreen.main.bounds.height
        }
        constrain(segmentedControll, view){ sc, vw in
            sc.bottom == vw.bottom - 35 / 736 * UIScreen.main.bounds.height
            sc.centerX == vw.centerX
        }
        constrain(leftButton, view){ lb, vw in
            lb.left == vw.left
            lb.bottom == vw.bottom
            lb.height == 100 / 736 * UIScreen.main.bounds.height
            lb.width == 85 / 414 * UIScreen.main.bounds.width
        }
        constrain(rightButton, view){ rb, vw in
            rb.right == vw.right
            rb.bottom == vw.bottom
            rb.height == 100 / 736 * UIScreen.main.bounds.height
            rb.width == 85 / 414 * UIScreen.main.bounds.width
        }
        constrain(tableViewList, view){tl,vw in
            tl.edges == vw.edges
        }
    }
    var currentIndex = 0
    @objc func typeChange(){
        if segmentedControll.selectedSegmentIndex == 0{
            mapView.mapType = MKMapType.standard
        }
        if segmentedControll.selectedSegmentIndex == 1{
            mapView.mapType = MKMapType.satellite
        }
        if segmentedControll.selectedSegmentIndex == 2{
            mapView.mapType = MKMapType.hybrid
        }
    }
    
    @objc func prevLocation(){
        currentIndex = currentIndex - 1
        if(currentIndex <= -1){
            currentIndex = markedPlaces.count - 1
        }
        let coordinate = CLLocationCoordinate2D(latitude: markedPlaces[currentIndex].latitude, longitude: markedPlaces[currentIndex].longitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000), animated: true)
        self.title = markedPlaces[currentIndex].title!
    }
    
    @objc func nextLocation(){
        currentIndex = currentIndex + 1
        if currentIndex >= markedPlaces.count {
            currentIndex = 0
        }
        let coordinate = CLLocationCoordinate2D(latitude: markedPlaces[currentIndex].latitude, longitude: markedPlaces[currentIndex].longitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000), animated: true)
        self.title = markedPlaces[currentIndex].title!
    }
    
    @objc func butPress() {
        if(tableViewList.isHidden) {
            tableViewList.isHidden = false
            myView.isHidden = true
//            blurEffect.alpha = 1
            
            
        } else {
            tableViewList.isHidden = true
            myView.isHidden = false
        }
        print("PRESSED!!!")
    }
    func barButton(){
        let button = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(butPress))
        navigationItem.rightBarButtonItem  = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.compact)
        self.navigationController?.navigationBar.alpha = 0.8
        button.tintColor = .black
    }
    @objc func infoSeg(){
        let vc = EditViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            let rightButton = UIButton(type: .infoLight)
            //rightButton.addTarget(self, action: #selector(info), for: .touchUpInside)
            rightButton.tag = annotation.hash
            rightButton.addTarget(self, action: #selector(infoSeg), for: .touchUpInside)
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            return pinView
        }
        else {
            return nil
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markedPlaces.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CellModel(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.titleLabel.text = markedPlaces[indexPath.row].title
        cell.subtitleLabel.text = markedPlaces[indexPath.row].subtitle
        cell.editingAccessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewList.isHidden = true
        let location = CLLocationCoordinate2DMake(markedPlaces[indexPath.row].latitude, markedPlaces[indexPath.row].longitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1000, 1000), animated: true)
        self.title = markedPlaces[indexPath.row].title
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            PersistenceService.context.delete(markedPlaces[indexPath.row])
            markedPlaces.remove(at: indexPath.row)
            tableView.reloadData()
            PersistenceService.saveContext()
            mapView.removeAnnotations(mapView.annotations)
            for (index, _) in markedPlaces.enumerated() {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: markedPlaces[index].latitude, longitude: markedPlaces[index].longitude)
                annotation.title = markedPlaces[index].title
                annotation.subtitle = markedPlaces[index].subtitle
                mapView.addAnnotation(annotation)
                
            }
            tableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
