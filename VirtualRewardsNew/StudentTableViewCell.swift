//
//  StudentTableViewCell.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/14/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var selectedStudents:[Int]!
    var index:Int?
    var inSearch:Bool!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    var currentClass = VirtualRewardsClient.sharedInstance.getClass()
    
    var student: Student?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = student?.name
        pointsLabel.text = ": \(student?.points)"
    }
    func reload(){
        nameLabel.text = student!.name
        pointsLabel.text = ": \(student!.points)"
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func plusAction(sender: AnyObject) {
        currentClass = VirtualRewardsClient.sharedInstance.getClass()
        student!.points = student!.points + 1
        
        if inSearch == false{
        currentClass.students[index!] = student!
        VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        }else{
        //currentClass.searchStudents[self.student!.name] = self.student!
        currentClass.updateStudent(self.student!)
        VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        }
        reload()
    }
    
    @IBAction func minusAction(sender: AnyObject) {
        currentClass = VirtualRewardsClient.sharedInstance.getClass()
        student!.points = student!.points - 1
        if inSearch == false{
            currentClass.students[index!] = student!
            VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        }else{
            //currentClass.searchStudents[self.student!.name] = self.student!
            currentClass.updateStudent(self.student!)
            VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        }
        reload()
    }
    
}
