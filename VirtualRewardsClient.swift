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
           // println("sdfd")
        }
        println("\(Static.instance) sdfd")
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
        var defaults = NSUserDefaults.standardUserDefaults()
        println("\(classRoom.students)odsljuf-98ioa[hjsodfjakdsnf[kjin")
        var encodedObject: NSData = NSKeyedArchiver.archivedDataWithRootObject(classRoom)
        defaults.setObject(encodedObject, forKey: classKey)
        defaults.synchronize()
    }
    
    func getClass() -> ClassRoom{
        var defaults = NSUserDefaults.standardUserDefaults()
        //println(defaults.objectForKey(classKey))
        var currentClass:ClassRoom!
        if let data = defaults.objectForKey(classKey) as? NSData{
            //let unarc = NSKeyedUnarchiver(forReadingWithData: data)
            //unarc.setClass(Class.self, forClassName: "Class")
            currentClass = NSKeyedUnarchiver.unarchiveObjectWithData(data) as ClassRoom
            println("entering \(currentClass.students)")
            //Class.sharedInstance.students = currentClass.students
            //Class.sharedInstance.teacher = currentClass.teacher
            return currentClass
            
        } else {
            var newClass = ClassRoom()
            newClass.students = [Student]()
            var encodedObject: NSData = NSKeyedArchiver.archivedDataWithRootObject(newClass)
            defaults.setObject(encodedObject, forKey: classKey)
            defaults.synchronize()
            return newClass
        }
    }
}
