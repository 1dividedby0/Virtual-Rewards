//
//  ClassRoom.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import Foundation
import UIKit

let classKey = "CLASS_KEY"
let studentsKey = "STUDENTS_KEY"
class ClassRoom: NSObject, NSCoding{
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    /*class var sharedInstance: ClassRoom{
        struct Static{
            static var instance:ClassRoom = VirtualRewardsClient.sharedInstance.getClass()
        }
        println("test6 Classroom sharedInstance");
        return Static.instance
    }*/
    var students:[Student] = [Student]()
    
    //var students:[Student] = sharedInstance.students
    //var teacher = Teacher(currentClass: sharedInstance)
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(students, forKey: studentsKey)
    }
    override init() {
        
    }
    required init(coder aDecoder: NSCoder) {
        //super.init()
        students = aDecoder.decodeObjectForKey(studentsKey) as [Student]
    }
    func addStudent(name: String, value: Int){
        self.students.append(Student(name: name, startingPoints: value))
        //defaults.setObject(ClassRoom.sharedInstance, forKey: classKey)
        VirtualRewardsClient.sharedInstance.updateSavedClass(self)
    }
    
    func addStudent(name: String){
        //println(VirtualRewardsClient.sharedInstance.getClass().students)
        students.append(Student(name: name))
        printClass()
        //defaults.setObject(ClassRoom.sharedInstance, forKey: classKey)
        //VirtualRewardsClient.sharedInstance.updateSavedClass(self)
    }
    
    func addStudents(students: [String]){
        self.students = VirtualRewardsClient.sharedInstance.getClass().students
        for name in students{
            println(name)
           self.addStudent(name)
        }
    }
    
    func printClass(){
        for i in students{
            println("Student: \(i.name), Points: \(i.points)")
        }
    }
}