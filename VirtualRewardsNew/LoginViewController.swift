//
//  LoginViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 4/1/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pigImage: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
        //self.errorLabel.hidden = true
        logInButton.backgroundColor = UIColor.yellowColor()
        logInButton.layer.cornerRadius = 7
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.blackColor().CGColor
        
        signUpButton.backgroundColor = UIColor.yellowColor()
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.blackColor().CGColor
        
        let image:UIImage = pigImage.image!
        pigImage.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                self.performSegueWithIdentifier("fromLogin", sender: self)
            }else{
                println(user)
                println(self.passwordTextField.text)
                self.errorLabel.textColor = UIColor.redColor()
                self.errorLabel.hidden = false
                let error = error!.userInfo!["error"] as! NSString
                self.errorLabel.text = "Whoops! \(error)"
            }
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.Next{
            self.passwordTextField.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return false
    }
    @IBAction func signUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("toSignUp", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}