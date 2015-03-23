//
//  AddStudentViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 3/15/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController {

    @IBOutlet weak var namesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addStudentAction(sender: AnyObject) {
        let namesString: String = namesTextField.text
        if namesString != ""{
        let namesArray: [String] = split(namesString){$0 == ","}
        var currentClass: ClassRoom = VirtualRewardsClient.sharedInstance.getClass()
        currentClass.addStudents(namesArray)
        println(currentClass.students.count)
        VirtualRewardsClient.sharedInstance.updateSavedClass(currentClass)
        println(VirtualRewardsClient.sharedInstance.getClass().printClass())
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
