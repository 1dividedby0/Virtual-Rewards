//
//  StudentDetailsViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 5/22/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit
import MessageUI
class StudentDetailsViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var name:String!
    var email:String!
    var student:Student!
    override func viewDidLoad() {
        super.viewDidLoad()
        println(nameTextField)
        self.nameTextField.text = name
        self.emailTextField.text = email
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    func back(sender: UIBarButtonItem){
        // save new name
        var students = VirtualRewardsClient.sharedInstance.getClass()
        for var i = 0; i < students.students.count; i++ {
            if self.name == students.students[i].name{
                students.students[i].name = nameTextField.text
                students.students[i].email = emailTextField.text
                VirtualRewardsClient.sharedInstance.updateSavedClass(students)
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendEmailButton(sender: AnyObject) {
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Your points")
        picker.setToRecipients([student.email])
        picker.setMessageBody("You have \(student.points) points in your class", isHTML: true)
        presentViewController(picker, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    

}
