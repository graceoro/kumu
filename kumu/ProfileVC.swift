//
//  ProfileVC.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/2/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import UIKit
//import FirebaseDatabase
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    // declare users ref instance variable
//    var usersRef = Database.database().reference().child("users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editProfileButton.layer.cornerRadius = 20
        logoutButton.layer.cornerRadius = 20
        profilePicImage.layer.cornerRadius = profilePicImage.frame.size.width/2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        Helper.helper.logOut()
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
