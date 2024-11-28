//
//  Person.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import Foundation

final class Person: Hashable, Identifiable, Codable {
    var id: UUID = UUID()
    var photo: String = ""
    var name: String = ""
    var age: Int = 0
    
    var isAdult: Bool {
        age >= 18
    }
    
    var balance: Double {
//        accounts.reduce(0) { $0 + $1.amount }
        0
    }
    
    init(id: UUID, photo: String, name: String, age: Int) {
        self.id = id
        self.photo = photo
        self.name = name
        self.age = age
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
