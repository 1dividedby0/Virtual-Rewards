//
//  Student.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import Foundation
import UIKit

class Student: NSObject, NSCoding{
    var name:String!
    var points:Int!
    var rewards:[String]!
    var email:String!
    var notes:String!
    init(name: String){
        self.name = name
        self.points = 0
    }
    init(name: String, startingPoints points: Int, email: String, notes: String){
        self.name = name
        self.points = points
        self.email = email
        self.notes = notes
    }
    //override init(){
        
    //}
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(points, forKey: "points")
        aCoder.encodeObject(email, forKey:"email")
        aCoder.encodeObject(notes, forKey:"notes")
    }
    
    required init(coder aDecoder: NSCoder) {
       self.name = aDecoder.decodeObjectForKey("name") as! String
       self.points = aDecoder.decodeIntegerForKey("points") as Int
       self.email = aDecoder.decodeObjectForKey("email") as? String
       self.notes = aDecoder.decodeObjectForKey("notes") as? String
    }
    
}