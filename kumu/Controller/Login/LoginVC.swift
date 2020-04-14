//
//  LoginVC.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/2/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 30
        signupButton.layer.cornerRadius = 30
        emailTF.layer.cornerRadius = 10
        emailTF.layer.borderWidth = 0.5
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.borderWidth = 0.5
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        
        errorMessageLabel.text = ""
        // Do any additional setup after loading the view.
        
        enableLoginButton(enabled: false)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        // observe text fields to enable log in button when appropriate
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check if user is already logged in
        // attach listener
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            // if authenticated
//            if user != nil {
            if let user = user {
                // print message
                print("User is already logged in")
                
                // automatically switch to success view
//                Helper.helper.switchVC(VC: "ProfileVC")
                Helper.helper.switchVC(VC: "tabBarControllerID")
            } else {
                print("Not logged in.")
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // detach the listener
        Auth.auth().removeStateDidChangeListener(handle!)
        
        // resign first responder fo all text fields
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }

    @IBAction func backgroundTouched(_ sender: Any) {
        // background button to dismiss keyboard
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // move to other text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        switch textField {
        // if return email text field, go to email text field
        case emailTF:
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
            break
        case passwordTF:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    

    func enableLoginButton(enabled: Bool) {
        if enabled {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        }
        else {
            loginButton.alpha = 0.7
            loginButton.isEnabled = false
        }
    }
    
    // enable the log in button if none of the text fields are empty
    @objc func textFieldChanged(_ target:UITextField) {
        let formFilled = emailTF.text != nil && emailTF.text != "" && passwordTF.text != nil && passwordTF.text != ""
        
        enableLoginButton(enabled: formFilled)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        // Implement
        handleSignIn()
        
        // dismiss keyboard
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    
    // handle sign up
    @objc func handleSignIn() {
        print("Log In Tapped!")
        
        // get the text from text fields (if any)
        guard let email = emailTF.text else { return }
        guard let pass = passwordTF.text else { return }
        
        /*
        // log in with password
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            // if login is not successful (error != nil)
            if error != nil {
                // print error
                print(error!.localizedDescription)
                // display error
                self.errorMessageLabel.text = error!.localizedDescription
                // return
                return
            } else {
                // switch to success view
//                Helper.helper.switchVC(VC: "ProfileVC")
                Helper.helper.switchVC(VC: "tabBarControllerID")
            }
        }
 */
   
        // [START headless_email_auth]
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // [START_EXCLUDE]
            if let error = error {
                strongSelf.errorMessageLabel.text = error.localizedDescription
                return
            }
            Helper.helper.switchVC(VC: "tabBarControllerID")
            
            // [END_EXCLUDE]
        }
        // [END headless_email_auth]
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
