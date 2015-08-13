//
//  SignUpViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 4/7/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pandaImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.orangeColor()
        self.view.backgroundColor = UIColor.cyanColor()
        // Do any additional setup after loading the view.
        usernameTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            confirmPasswordTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return false
    }

    @IBAction func signUpAction(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        if passwordTextField.text == confirmPasswordTextField.text{
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil{
                myKeyChainWrapper.mySetObject(self.passwordTextField.text, forKey: kSecValueData)
                myKeyChainWrapper.writeToKeychain()
                defaults.setObject(self.usernameTextField.text, forKey: usernameKey)
                self.performSegueWithIdentifier("fromSignUp", sender: self)
            }else{
                //println(error.userInfo!["error"] as NSString)
                var alert = UIAlertView()
                alert.title = "Something went wrong..."
                alert.message = error!.userInfo!["error"] as? String
                alert.addButtonWithTitle("OK")
                if error!.userInfo!["error"]?.rangeOfString("already taken") != nil{
                alert.message = "An evil panda has consumed this account."
                }
                alert.show()
            }
        }
        }else{
            var alert = UIAlertView()
            alert.title = "Something went wrong..."
            alert.message = "Confirmation password doesn't match"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
