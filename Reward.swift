//
//  Reward.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 8/2/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import Foundation
import UIKit

class Reward: NSObject, NSCoding{
    var name: String!
    var pointsReq:Int!
    init(name: String){
        self.name = name;
        self.pointsReq = 0;
    }
    init(name: String, pointsReq: Int){
        self.name = name;
        self.pointsReq = pointsReq;
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name");
        aCoder.encodeObject(pointsReq, forKey:"pointsReq")
    }
    required init(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.pointsReq = aDecoder.decodeIntegerForKey("pointsReq") as Int
    }
}