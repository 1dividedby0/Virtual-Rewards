//
//  VirtualRewardsClient.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class VirtualRewardsClient{
    
    class var sharedInstance: VirtualRewardsClient{
        struct Static{
            static var instance = VirtualRewardsClient()
        }
        return Static.instance
    }
    
    func searchWithTerm(term: String) -> [Student]{
        var term1 = term
        var currentClass = getClass()
        var students = currentClass.students
        var selectedStudents: [Student] = [Student]()
        if term1 == ""{
            return currentClass.students
        }else{
            term1.replaceRange(term1.startIndex...term1.startIndex, with: String(term1[term1.startIndex]).capitalizedString)
        }
        for student in students{
            let name = student.name
            if name.rangeOfString(term1) != nil{
                selectedStudents.append(student)
                continue
            }else{
                continue
            }
        }
        return selectedStudents
    }
    
    func updateSavedClass(classRoom:ClassRoom){
        var encodedObject: NSData = NSKeyedArchiver.archivedDataWithRootObject(classRoom)
        var currentUser:PFUser = PFUser.currentUser()!
        currentUser["class"] = encodedObject
        currentUser.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error != nil && success == false{
                var alert = UIAlertView()
                alert.title = "Something went wrong"
                alert.message = error!.userInfo!["error"] as? String
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    func getClass() -> ClassRoom{
        var currentClass:ClassRoom!
        let data: AnyObject? = PFUser.currentUser()?["class"]
        if let data: AnyObject = data{
            currentClass = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData)as! ClassRoom
            return currentClass
        } else {
            var newClass = ClassRoom()
            newClass.students = [Student]()
            var encodedObject: NSData = NSKeyedArchiver.archivedDataWithRootObject(newClass)
            return newClass
        }
    }
}
