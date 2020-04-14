//
//  Account.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/13/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import Foundation

struct Appt:Equatable {
    public var tutor:String
    public var date:String
    public var time:String
    public var location:String
    public var description:String
    
    init(tutor: String, date: String, time: String, location: String, description: String) {
        self.tutor = tutor
        self.time = time
        self.location = location
        self.date = date
        self.description = description
    }
}

struct Account:Equatable {
    public var fullName:String
    private var uid:String
    private var profPic:String
    public var year:String
    public var major:String
    public var minor:String
    public var tutoringArr:[String] // classes you are tutoring
    private var apptsArr:[Appt]     // your appointments
    
    
    init(fullName: String, uid: String, profPic: String, year: String,
         major:String, minor: String, tutoringArr: [String], apptsArr: [Appt]) {
        self.fullName = fullName
        self.uid = uid
        self.profPic = profPic
        self.year = year
        self.major = major
        self.minor = minor
        self.tutoringArr = tutoringArr
        self.apptsArr = apptsArr
    }
    
    func getuid() -> String {
        return uid
    }
    
    func getProfPic() -> String {
        return profPic
    }
    
    func getApptsArr() -> [Appt] {
        return apptsArr
    }
    
    func getClasses() -> String {
        var resultStr:String = ""
        
        if tutoringArr.count > 0 {
            for item in tutoringArr {
                resultStr = "\(resultStr) \n \(item)"
            }
        }
        else {
            resultStr = "none"
        }
        return resultStr
    }
    
    mutating func insertAppt(appt: Appt) {
        apptsArr.append(appt)
    }
    
    mutating func deleteAppt(i: Int) {
        apptsArr.remove(at: i);
    }
    
    mutating func insertClass(newClass: String) {
        tutoringArr.append(newClass)
    }
    
    mutating func deleteClass(i: Int) {
        tutoringArr.remove(at: i)
    }

    
}
