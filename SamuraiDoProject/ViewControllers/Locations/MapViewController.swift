//
//  MapViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 16/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.addAnnotations(JudoClub.allClubs())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
