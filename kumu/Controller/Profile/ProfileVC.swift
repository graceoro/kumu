//
//  ProfileVC.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/2/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var classesLabel: UILabel!
    @IBOutlet weak var editClassesButton: UIButton!
    // declare users ref instance variable
//    var usersRef = Database.database().reference().child("users")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // clear the labels
        fullNameLabel.text = "";
        yearLabel.text = "";
        majorLabel.text = "";
        minorLabel.text = "";
        classesLabel.text = "";
        
//        initFromDatabase()
        var rootRef: DatabaseReference!
        rootRef = Database.database().reference()
        guard let currUserID = Auth.auth().currentUser?.uid else { return }
        rootRef.child("users").child(currUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
            
            let value = snapshot.value as! NSDictionary
            let fullName = value["name"] as! String
            self.fullNameLabel.text = fullName
            
            let collegeInfo = value["collegeInfo"] as! NSDictionary
            let year = collegeInfo["year"] as! String
            let major = collegeInfo["major"] as! String
            let minor = collegeInfo["minor"] as! String
            self.yearLabel.text = year
            self.majorLabel.text = major
            self.minorLabel.text = minor
            
            let urlStr = value["profPic"] as! String
//            let url = URL(fileURLWithPath: filePath)
//            if let photodata = try? Data(contentsOf: url) {
//                self.profilePicImage.image = UIImage(data: photodata)
//            }
            
            let url = URL(string: urlStr)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                //let image = UIImage(data: imageData)
                self.profilePicImage.image = UIImage(data: imageData)
            }
            
            
            let tutoringDict = value["classesTutoringInfo"] as! [String]
            if tutoringDict.count > 1 {
                // then add to the person's profile and stuff
                var classesString = ""
                for i in (1...tutoringDict.count) {
                    let addText = tutoringDict[i]
                    classesString = "\(classesString)\n\(addText)"
                }
                self.classesLabel.text = classesString
            }
            
            let apptDict = value["appointments"] as! NSArray
            if apptDict.count > 1 {
                // then add to the person's profile and stuff
                for i in (1...apptDict.count) {
                    let apptInfo = apptDict[i] as! [String:String]
                    let tutor = apptInfo["tutor"]
                    let date = apptInfo["date"]
                    let time = apptInfo["time"]
                    let location = apptInfo["location"]
                    let description = apptInfo["description"]
                    
                    print("tutor: \(tutor)")
                    print("date: \(date)")
                    print("time: \(time)")
                    print("location: \(location)")
                    print("description: \(description)")
                }
            }
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
//        let user = Auth.auth().currentUser
//        if let user = user {
//            // The user's ID, unique to the Firebase project.
//            let uid = user.uid
//            let email = user.email
//            let displayName = user.displayName
//            guard let photoURL = user.photoURL else { return }
//            // [START_EXCLUDE]
//            if let data = try? Data(contentsOf: photoURL) {
//                profilePicImage.image = UIImage(data: data)
//            }
//            fullNameLabel.text = displayName
//            yearLabel.text = "uid: \(uid)";
//            majorLabel.text = "email: \(email)";
//
//        }

        // Do any additional setup after loading the view.
        
        editProfileButton.layer.cornerRadius = 20
        logoutButton.layer.cornerRadius = 20
        profilePicImage.layer.cornerRadius = profilePicImage.frame.size.width/2
    }
    
    /*
    func initFromDatabase() {
        // initialize full name label as empty string
        self.fullNameLabel.text = ""
        
        // declare constant for current user object
        let currentUser = Auth.auth().currentUser
        
        // declare constant for current user UID
        let currentUID = currentUser?.uid as! String
        
        // get full name from Database based on UID
        usersRef.child(currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user snapshot (dictionary)
            let userSnapshot = snapshot.value as? NSDictionary
            
            // get full name
            let fullName = userSnapshot?["fullName"] as? String ?? ""
            
            // set label to full name
            self.userFullName.text = fullName
            
        }) { (error) in
            print(error.localizedDescription)
            
            // set full name to empty string
            self.userFullName.text = ""
        }

    }
 */
    
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
