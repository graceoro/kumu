//
//  AccountsDataModel.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/13/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class AccountsModel: NSObject, AccountsDataModel {
    static let sharedInstance = AccountsModel()
    
    func numberOfAccounts() -> Int {
        return accounts.count
    }
    
    func account(at index: Int) -> Account? {
        if index >= 0 && index < accounts.count {
            return accounts[index]
        }
        return nil
    }
    
    func currentAccount() -> Account? {
        if let currIndex = currentIndex {
            return accounts[currIndex]
        }
        return nil
        
    }

  
    func insert(fullName: String, uid: String, profPic: String, year: String,
                major:String, minor: String, tutoringArr: [String], apptsArr: [Appt],
                at index: Int) {
        if index <= accounts.count {
            accounts.insert(Account(fullName: fullName, uid: uid, profPic: profPic, year: year,
                                    major:major, minor: minor, tutoringArr: tutoringArr, apptsArr: apptsArr), at: index)
            
            save()
        }
        
    }
    
    func addAppointment(appt: Appt) {
        if var currAcc = currentAccount() {
            currAcc.insertAppt(appt: appt)
        }
        save()
    }
    
    func removeAppoitnment(idx: Int) {
       if var currAcc = currentAccount() {
            currAcc.deleteAppt(i: idx)
        }
        save()
    }
    
    func addTutoringClass(myClass: String) {
        if var currAcc = currentAccount() {
            currAcc.insertClass(newClass: myClass)
        }
    }
    
    func removeTutoringClass(myClass: String) {
        if var currAcc = currentAccount() {
            var counter = 0
            for item in currAcc.tutoringArr {
                if item == myClass {
                    break
                }
                else {
                    counter+=1
                }
            }
            currAcc.deleteClass(i: counter)
        }
        
        
        
    }
    
    
    
   
//
//
//    func rearrageFlashcards(from: Int, to: Int) {
//        if from < flashcards.count && from >= 0 && to < flashcards.count && to >= 0 {
//            // Store flashcard info from the "from" flashcard
//            if let f = flashcard(at: from) {
//                removeFlashcard(at: from)
//                insert(question: f.getQuestion(), answer: f.getAnswer(), favorite: f.isFavorite, at: to)
//            }
//            save()
//        }
//    }
//
    
    // Loop through your cards and check each question.
    // You should probably also used .lowercased() to account for letter variations.
    // This check doesn’t need to be exhaustive – use .contains().
//    func checkAskedQuestion(potentialQuestion: String) -> Bool {
//        // do i need to check if the string is empty/has nothing?
//        var exists = false;
//        for card in flashcards {
//            if(card.getQuestion().lowercased().contains(potentialQuestion.lowercased())) {
//                exists = true;
//                break
//            }
//        }
//        return exists
//    }
    
    
    // Only called by methods in Model
    private func save() {
        
    }
    
    
    //private var flashcards:Array<Flashcard>
    private var accounts = [Account]()
    private var currentIndex:Int?
    
    override init() {
        // read in once from the database in the beginning and initialize the vars.
    
    }
    
    
    
    
}
