//
//  Helper.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/2/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Helper {
    static let helper = Helper()
    
    // switch to another viewcontroller
    func switchVC(VC: String) {
        // create main storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        /*
        // from main storyboard, instantiate success view
        let newVC = storyboard.instantiateViewController(withIdentifier: VC)
        // get the app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // set the success view controller as root view controller
        appDelegate.window?.rootViewController = newVC
        */
        
         let appDelegate = UIApplication.shared.delegate! as! AppDelegate
         
         let initialViewController = storyboard.instantiateViewController(withIdentifier: VC)
         appDelegate.window?.rootViewController = initialViewController
         appDelegate.window?.makeKeyAndVisible()    // added
         
         
    }
    
    // log out function
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        
        // switch to loginViewController
        switchVC(VC: "LoginVC")
        
    }
    
}
