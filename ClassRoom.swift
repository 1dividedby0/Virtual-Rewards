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
    var total:Int = 0
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var students:[Student] = [Student]()

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(students, forKey: studentsKey)
    }
    override init() {
    }
    required init(coder aDecoder: NSCoder) {
        students = aDecoder.decodeObjectForKey(studentsKey) as! [Student]!
    }
    
    func findTotal() -> Int{
        for student in students{
            self.total += student.points
        }
        return self.total
    }
    
    func updateStudent(student:Student){
        var index = 0
        for stud in students{
            if stud.name == student.name{
                students[index] = student
            }
            index++
        }
    }
    
    func addStudent(name: String, value: Int){
        self.students.append(Student(name: name, startingPoints: value, email: ""))
        VirtualRewardsClient.sharedInstance.updateSavedClass(self)
    }
    
    func addStudent(name: String){
        students.append(Student(name: name))
        printClass()
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
    
    func removeStudent(student:Student){
        students = VirtualRewardsClient.sharedInstance.getClass().students
        var indices = 0
            for stud in students{
                if stud.name == student.name{
                    students.removeAtIndex(indices)
                }
                indices++
            }
        printClass()
    }
    
    func printClass(){
        for i in students{
            println("Student: \(i.name), Points: \(i.points)")
        }
    }
}