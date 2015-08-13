//
//  LoginViewController.swift
//  VirtualRewardsNew
//
//  Created by Dhruv Mangtani on 4/1/15.
//  Copyright (c) 2015 dhruv.mangtani. All rights reserved.
//

import UIKit
import AVFoundation
import LocalAuthentication
let passwordKey: String = "PASSWORDSJFKSJDd34fFLK"
let usernameKey: String = "USERNAMEFDKSJFLKJSDFLJS%(#JK"
let myKeyChainWrapper: KeychainWrapper = KeychainWrapper()
let defaults = NSUserDefaults.standardUserDefaults()
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var TouchIDButton: UIButton!
    var error: NSError?
    var context = LAContext()
    var loginDefaultsKey: String = "LOGINDEFAULTSABCGHICDEXYZ"
    @IBOutlet weak var pigImage: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
        //self.errorLabel.hidden = true
        //logInButton.backgroundColor = UIColor.redColor()
        //logInButton.layer.cornerRadius = 7
        //logInButton.layer.borderWidth = 1
        //logInButton.layer.borderColor = UIColor.blackColor().CGColor
        
        //signUpButton.backgroundColor = UIColor.redColor()
        //signUpButton.layer.cornerRadius = 5
        //signUpButton.layer.borderWidth = 1
        //signUpButton.layer.borderColor = UIColor.blackColor().CGColor
        
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
                myKeyChainWrapper.mySetObject(self.passwordTextField.text, forKey: kSecValueData)
                myKeyChainWrapper.writeToKeychain()
                defaults.setObject(self.usernameTextField.text, forKey: usernameKey)
                self.performSegueWithIdentifier("fromLogin", sender: self)
            }else{
                var alert = UIAlertView()
                alert.title = "Invalid Login"
                alert.message = error!.userInfo!["error"] as? String
                alert.addButtonWithTitle("OK")
                alert.show()
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
    @IBAction func touchIDAction(sender: AnyObject) {
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with Touch ID",
                reply: { (success: Bool, error: NSError! ) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        var password: String = myKeyChainWrapper.myObjectForKey(kSecValueData) as! String
                        if success && password != "" {
                        PFUser.logInWithUsernameInBackground(defaults.objectForKey(usernameKey) as! String, password: myKeyChainWrapper.myObjectForKey(kSecValueData) as! String, block: { (user: PFUser?, error: NSError?) -> Void in
                            if user != nil{
                                self.performSegueWithIdentifier("fromLogin", sender: self)
                            }
                            else{
                                //println()
                                var alert = UIAlertView()
                                alert.title = "Invalid Login"
                                alert.message = error!.userInfo!["error"] as? String
                                alert.addButtonWithTitle("OK")
                                alert.show()
                            }
                        })
                        }
                        if error != nil{
                            var message:String = ""
                            var showAlert: Bool
                            
                            switch(error.code){
                            case LAError.AuthenticationFailed.rawValue:
                                message = "There was a problem verifying your identity"
                                showAlert = true
                            case LAError.UserCancel.rawValue:
                                showAlert = false
                            case LAError.UserFallback.rawValue:
                                showAlert = false
                            default:
                                showAlert = true
                                message = "Touch ID may not have been configured"
                            }
                            var alert = UIAlertView()
                            alert.title = "Error"
                            alert.message = message
                            alert.addButtonWithTitle("OK")
                            if showAlert{
                                alert.show()
                            }
                        }
                    })
            })
        }else{
            var alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Touch ID not configured or unavailable"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
