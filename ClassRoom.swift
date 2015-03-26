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
    
    var students:[Student] = [Student]()
    
    func encodeWithCoder(aCoder: NSCoder) {
        println(students)
        aCoder.encodeObject(students, forKey: studentsKey)
    }
    override init() {
        
    }
    required init(coder aDecoder: NSCoder) {
        students = aDecoder.decodeObjectForKey(studentsKey) as [Student]!
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
            if VirtualRewardsClient.sharedInstance.searchWithTerm(name).isEmpty{
                var selected = name
                selected.replaceRange(name.startIndex...name.startIndex, with: String(name[name.startIndex]).capitalizedString)
                self.addStudent(selected)
            }
        }
    }
    
    func removeStudent(index: Int){
        students = VirtualRewardsClient.sharedInstance.getClass().students
        students.removeAtIndex(index)
        printClass()
    }
    
    func printClass(){
        for i in students{
            println("Student: \(i.name), Points: \(i.points)")
        }
    }
}