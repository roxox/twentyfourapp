//
//  Grouping.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.03.21.
//

import Foundation
import Firebase

struct Grouping: Codable, Identifiable {
    var id: String?
    var title: String
    
    init(title: String) {
        id = nil
        self.title = title
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let title = data["title"] as? String else {
            return nil
        }
        
        id = document.documentID
        self.title = title
    }
}
