//
//  User.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.03.21.
//

import Foundation
import Firebase
import CoreLocation
import SwiftUI

struct User: Codable, Identifiable, Hashable {
    
    var id: String?
    var name: String
    var imageLink: String
    var imagedata: Data = .init(count: 0)
    var isFoodSelected: Bool
//    fileprivate var location: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: location.latitude,
//            longitude: location.longitude)
//    }
    
    init(name: String, imageLink: String, lang: Double, long: Double, id: String?, isFoodSelected: Bool) {
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.isFoodSelected = isFoodSelected
//        self.image = UIImage(data: loadImage(imageLink))
//        self.location = Coordinates(latitude: lang, longitude: long)
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else {
            return nil
        }
        
        guard let imageLink = data["imageLink"] as? String else {
            return nil
        }
        
        guard let isFoodSelected = data["isFoodActive"] as? Bool else {
            return nil
        }
        
//        guard let location = data["location"] as? GeoPoint else {
//            return nil
//        }
        
        id = document.documentID
        self.name = name
        self.imageLink = imageLink
        self.isFoodSelected = isFoodSelected
//        self.location = Coordinates(latitude: location.latitude, longitude: location.longitude)
    }
    
    func loadImage(_ imageLink: String) -> Data{
        
        let db = Firestore.firestore()
        let storage = Storage.storage()
        
        var userImage = UIImage()
        var imageData = Data()
        // Reference to an image file in Firebase Storage
        let storageRef = storage.reference(withPath: "profilepics/\(imageLink)")
        //        let reference = storageRef.child("images/stars.jpg")
        storageRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
            if let error = error {
                print("Storage Error: \(error)")
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
//                                    let image = UIImage(data: data!)
                print("Storage Image loaded")
                let image = UIImage(data: data!)
                userImage = image ?? UIImage(systemName: "person")!
                
                imageData = data!
            }
        }
        
        return imageData
    }

}

extension User {

    var image: Image {
//        UIImage()
        Image(uiImage: UIImage())
//        Image(uiImage: UIImage(data: loadImage(self.imageLink)) ?? UIImage())
        }
}

extension User: DatabaseRepresentation {
    
    var representation: [String : Any] {
//        var rep = ["name": name, "imageLink": imageLink, "location": location] as [String : Any]
        var rep = ["name": name, "imageLink": imageLink, "isFoodActive": isFoodSelected] as [String : Any]
        
        if let id = id {
            rep["id"] = id
        }
        
        return rep
    }
    
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

extension User: Comparable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.name < rhs.name
    }
}
