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
    @IBOutlet weak var notesTextField: UITextView!
    var name:String!
    var email:String!
    var notes:String!
    var student:Student!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.text = name
        self.emailTextField.text = email
        self.notesTextField.text = notes
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.notesTextField.delegate = self
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        self.notesTextField.layer.borderWidth=1
        self.notesTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.notesTextField.text="Notes"
        self.notesTextField.textColor = UIColor.lightGrayColor()
        
    }
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView.textColor == UIColor.lightGrayColor()){
            textView.text = nil;
            textView.textColor = UIColor.blackColor()
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Notes"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    func back(sender: UIBarButtonItem){
        // save new name
        var students = VirtualRewardsClient.sharedInstance.getClass()
        for var i = 0; i < students.students.count; i++ {
            if self.name == students.students[i].name{
                students.students[i].name = nameTextField.text
                students.students[i].email = emailTextField.text
                students.students[i].notes = notesTextField.text
                VirtualRewardsClient.sharedInstance.updateSavedClass(students)
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendEmailButton(sender: AnyObject) {
        if (MFMailComposeViewController.canSendMail()){
        var students = VirtualRewardsClient.sharedInstance.getClass()
        for var i = 0; i < students.students.count; i++ {
            if self.name == students.students[i].name{
                students.students[i].name = nameTextField.text
                students.students[i].email = emailTextField.text
                students.students[i].notes = notesTextField.text
                VirtualRewardsClient.sharedInstance.updateSavedClass(students)
            }
        }           
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Your points")
        picker.setToRecipients([emailTextField.text])
        picker.setMessageBody("You have \(student.points) points in your class", isHTML: true)
        presentViewController(picker, animated: true, completion: nil)
        }else{
            var alert = UIAlertView()
            alert.title = "No Account Found"
            alert.message = "There is currently no ICloud account signed into this device"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    

}
