//
//  Contact.swift
//  goodwed
//
//  Created by omarKaabi on 8/5/2023.
//

import Foundation
import SwiftUI

struct Contact: Identifiable {
    let imageName: String
    let name: String
    let phone: String
    let email: String
    let address: String
    
    let id = UUID()
}

let contacts = [
    Contact(imageName: "login", name: "Bernard Law", phone: "+1(268)-8110134", email: "blaw@yeilmail.com", address: "242 Wildrose River 16040 Wisconsin"),
    Contact(imageName: "login", name: "Caroline Phan", phone: "+1(698)-1881047", email: "cphan@neymail.com", address: "249 Modoc Half 75290 Kansas"),
    Contact(imageName: "login", name: "Eva Flint", phone: "+1(234)-3442899", email: "eflint@zuimail.com", address: "952 Baker Haggerty 90562 Mississippi"),
    Contact(imageName: "login", name: "Harry Green", phone: "+1(765)-7448466", email: "hgreen@neymail.com", address: "176 Flanigan Road 49223 Washington"),
    Contact(imageName: "login", name: "Helen Mora", phone: "+1(213)-5115553", email: "hmora@vuomail.com", address: "635 Prospect River 58641 Kansas"),
    Contact(imageName: "login", name: "Jimmy Sky", phone: "+1(453)-0663954", email: "jsky@ypmail.com", address: "763 University Trail 81701 Michigan")
]
