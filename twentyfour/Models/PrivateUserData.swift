//
//  PrivateUserData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.03.21.
//

import Foundation
import Firebase

struct PrivateUserData: Codable, Identifiable {
    var id: String?
    var email: String
    
    init(email: String) {
        id = nil
        self.email = email
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let email = data["email"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.email = email
    }
}
