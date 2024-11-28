//
//  User.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 24.07.24.
//

import SwiftUI

final class User: Codable {
    var mail: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var passwordCode: String = ""
    var person: Person?
    
    init(mail: String, phoneNumber: String, password: String, passwordCode: String, person: Person? = nil) {
        self.mail = mail
        self.phoneNumber = phoneNumber
        self.password = password
        self.passwordCode = passwordCode
        self.person = person
    }
}
