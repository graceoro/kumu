//
//  SignupVC.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/2/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var majorTF: UITextField!
    @IBOutlet weak var minorTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createAccountButton.layer.cornerRadius = 20
        
        errorMessageLabel.text = ""
        
        enableSignUpButton(enabled: false)
        
        // declare delegates
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        yearTF.delegate = self
        majorTF.delegate = self
        minorTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        // observe text fields to enable sign up button when appropriate
        firstNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        lastNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
//        yearTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
//        majorTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // immediately make fullNameTF first responder
        firstNameTF.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // resign first responder fo all text fields
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    // disable automatic keyboard dismissal
    override var disablesAutomaticKeyboardDismissal: Bool {
        return false
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        // background button to dismiss keyboard
        self.firstNameTF.resignFirstResponder()
        self.lastNameTF.resignFirstResponder()
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    
    // enable the sign up button if none of the text fields are empty
    @objc func textFieldChanged(_ target:UITextField) {
        
        // check if form is filled (bool)
        let formFilled = firstNameTF.text != nil && firstNameTF.text != ""
                    && lastNameTF.text != nil && lastNameTF.text != ""
//                    && yearTF.text != nil && yearTF.text != ""
                    && emailTF.text != nil && emailTF.text != ""
                    && passwordTF.text != nil && passwordTF.text != ""
        
        // enable sign up if form is filled
        enableSignUpButton(enabled: formFilled)
    }
    
    func enableSignUpButton(enabled:Bool) {
        
        // if enabled
        if enabled {
            // if sign up button is enabled
            // set alpha too 100% and set bool isEnabled to true
            createAccountButton.alpha = 1.0
            createAccountButton.isEnabled = true
        } else {
            // else if sign up button is disabled
            // reduce alpha and set bool isEnabled to false
            createAccountButton.alpha = 0.5
            createAccountButton.isEnabled = false
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        // dismiss back to main screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        handleCreateAccount()
    }
    
    // declare handle sign up function
    @objc func handleCreateAccount() {
        print("Create Account Tapped!")
        
        // get text from text fields
//        guard let firstName = firstNameTF.text else { return }
//        guard let lastName = lastNameTF.text else { return }
        guard let firstName = firstNameTF.text, let lastName = lastNameTF.text else { return }
        let fullName = firstName + lastName
        guard let email = emailTF.text else { return }
        guard let pass = passwordTF.text else { return }
        
        // create user in firebase
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            // if user is not nil and error is nil
            if error == nil && user != nil {
                
                // print status
                print("User created successfully")
                
                // create new user in database
//                let newUser = Database.database().reference().child("users").child(user!.uid)
//
//                // update current user information at this location
//                newUser.setValue(["fullName": "\(fullName)", "id" : "\(user!.uid)", "email": "\(email)"])
                
                // resign first responder
                self.firstNameTF.resignFirstResponder()
                self.lastNameTF.resignFirstResponder()
                self.emailTF.resignFirstResponder()
                self.passwordTF.resignFirstResponder()
                
                // switch to success view controller
                Helper.helper.switchVC(VC: "ProfileVC")
            } else {
                // print error
                print("Error: \(error!.localizedDescription)")
                
                // display error
                self.errorMessageLabel.text = error!.localizedDescription
            }
        }
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
