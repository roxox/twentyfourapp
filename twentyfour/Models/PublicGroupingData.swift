//
//  PublicGroupingData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import Foundation
import Firebase

struct PublicGroupingData: Codable, Identifiable {
    var id: String?
    var description: String
    
    init(description: String) {
        id = nil
        self.description = description
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let description = data["description"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.description = description
    }
}
