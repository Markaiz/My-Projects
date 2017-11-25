//
//  JudoClub.swift
//  SamuraiDoProject
//
//  Created by Mark on 16/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class JudoClub: NSObject {

    let name : String
    let location : CLLocation
    
    
    //destination
    
    init(name : String, latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        self.name = name
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        
        super.init()
        
    }

 class func allClubs() -> [JudoClub]
 {
    return[
    JudoClub(name: "Rishon le Zion ,Haviv School", latitude: 31.963754, longitude: 34.808069),
        JudoClub(name: "Rishon Le Zion ,Salmon School", latitude:31.9718376 , longitude: 34.801969),
        JudoClub(name: "Rishon Le Zion ,Gan Nahum School", latitude:31.9558787 , longitude: 34.8039647),
        JudoClub(name: "Rishon Le Zion, Ramat Eliau School", latitude: 31.9798807, longitude: 34.7948691),
       //snif rehovot
        //snif nes ciona
        //snif ariel
        //snif ramle
        //snif ....
    ]
    
    
    
    
    }


}

extension JudoClub : MKAnnotation{
    var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }
    
    var title : String?{
        return self.name
}
}
