//
//  AddStudentViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/15/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var namesTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTextField.delegate = self
        namesTextField.addTarget(self, action: "edit", forControlEvents: UIControlEvents.EditingChanged)
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.backgroundColor = UIColor.orangeColor()
        self.view.backgroundColor = UIColor.cyanColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func edit(){
        println("dsg")
        println(namesTextField.text)
        if namesTextField.text.isEmpty == false{
            println("editing")
            doneButton.enabled = true
        }else{
            doneButton.enabled = false
        }
    }
    
    @IBAction func addStudentAction(sender: AnyObject) {
        let namesString: String = namesTextField.text
        if namesString != ""{
        let namesArray: [String] = split(namesString){$0 == ","}
        var currentClass: ClassRoom = VirtualRewardsClient.sharedInstance.getClass()
        currentClass.addStudents(namesArray)
        VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        }
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
