//
//  PublicUserData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 12.03.21.
//

import Foundation
import Firebase

struct PublicUserData: Codable, Identifiable {
    var id: String?
    var about: String
    
    init(about: String) {
        id = nil
        self.about = about
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let about = data["about"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.about = about
    }
}
