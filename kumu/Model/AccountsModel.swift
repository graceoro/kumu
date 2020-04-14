//
//  AccountsModel.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/13/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import Foundation

//used for the data model
protocol AccountsDataModel {
    func numberOfAccounts() -> Int
    func account(at index: Int) -> Account?
    func insert(fullName: String, uid: String, profPic: String, year: String,
                major:String, minor: String, tutoringArr: [String], apptsArr: [Appt],
                at index: Int)
    func currentAccount() -> Account?
    
    func addAppointment(appt: Appt)
    
    func removeAppoitnment(idx: Int)
    
    func addTutoringClass(myClass: String)
    
    func removeTutoringClass(myClass: String)
    }

    
//    func removeFlashcard(at index: Int)
    
    //added functions
//    func rearrageFlashcards(from: Int, to: Int)

