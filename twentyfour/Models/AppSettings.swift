//
//  AppSettings.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import Foundation
import Firebase

struct AppSettings: Codable, Identifiable {
    var id: String?
    var currency: String
    var distanceUnit: String
    var isConditionsAccepted: Bool
    
    init(currency: String, distanceUnit: String, isConditionsAccepted: Bool) {
        id = nil
        self.currency = currency
        self.distanceUnit = distanceUnit
        self.isConditionsAccepted = isConditionsAccepted
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let currency = data["currency"] as? String else {
            return nil
        }
        guard let distanceUnit = data["distanceUnit"] as? String else {
            return nil
        }
        guard let isConditionsAccepted = data["isConditionsAccepted"] as? Bool else {
            return nil
        }
        
        id = document.documentID
        self.currency = currency
        self.distanceUnit = distanceUnit
        self.isConditionsAccepted = isConditionsAccepted
    }
}
