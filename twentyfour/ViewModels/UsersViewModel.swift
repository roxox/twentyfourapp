//
//  UserCollectionView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import Foundation
import FirebaseFirestore
import Firebase

class UsersViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @Published var testUserId: String?
    
    // Published and saved to local device
    @Published var users = [User]()
    
    @Published var showNewUserName: Bool = UserDefaults.standard.bool(forKey: "showNewUserName"){
        didSet {
            UserDefaults.standard.set(self.showNewUserName, forKey: "showNewUserName")
            NotificationCenter.default.post(name: NSNotification.Name("showNewUserNameChange"), object: nil)
        }
    }
    
    @Published var selectedPage: String = UserDefaults.standard.string(forKey: "selectedPage") ?? "login"{
        didSet {
            UserDefaults.standard.set(self.selectedPage, forKey: "selectedPage")
            NotificationCenter.default.post(name: NSNotification.Name("selectedPageChange"), object: nil)
        }
    }
    
    @Published var showLogin: Bool = UserDefaults.standard.bool(forKey: "showLogin"){
        didSet {
            UserDefaults.standard.set(self.showLogin, forKey: "showLogin")
            NotificationCenter.default.post(name: NSNotification.Name("showLoginChange"), object: nil)
        }
    }
    
    @Published var showRegister: Bool = UserDefaults.standard.bool(forKey: "showRegister"){
        didSet {
            UserDefaults.standard.set(self.showRegister, forKey: "showRegister")
            NotificationCenter.default.post(name: NSNotification.Name("showRegisterChange"), object: nil)
        }
    }
    
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn"){
        didSet {
            UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
            NotificationCenter.default.post(name: NSNotification.Name("isLoggedInChange"), object: nil)
        }
    }
    
    @Published var currentUserImageUrl: String = (UserDefaults.standard.string(forKey: "currentUserImageUrl") ?? "") {
        didSet {
            UserDefaults.standard.set(self.selectedPage, forKey: "currentUserImageUrl")
            NotificationCenter.default.post(name: NSNotification.Name("currentUserImageUrlChange"), object: nil)
        }
    }
    
    @Published var isLoading: Bool = UserDefaults.standard.bool(forKey: "isLoading"){
        didSet {
            UserDefaults.standard.set(self.isLoading, forKey: "isLoading")
            NotificationCenter.default.post(name: NSNotification.Name("isLoadingChange"), object: nil)
        }
    }
    
    func addNewUserFromData(_ name: String, _ imageLing: String, _ id: String) {
        self.isLoading = true
        do {
            let uid = Auth.auth().currentUser?.uid
            let newUser = User(name: name, imageLink: imageLing, lang: 0, long: 0, id: uid, isFoodSelected: false)
            try db.collection("users").document(newUser.id!).setData(newUser.representation) { _ in
                self.showNewUserName = false
                self.showLogin = false
                self.showRegister = false
                self.isLoggedIn = true
                self.selectedPage = "login"
                self.isLoading = false
            }
        } catch let error {
            self.isLoading = false
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func addNewUserProfileImage(_ data: Data, _ uid: String, _ name: String) {
        self.isLoading = true
        // Create a root reference
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let imageRef = storageRef.child("images/\(uid)")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    self.isLoading = false
                    // Uh-oh, an error occurred!
                    return
                }
                self.currentUserImageUrl = downloadURL.absoluteString
                print(self.currentUserImageUrl)
                self.addNewUserFromData(name, downloadURL.absoluteString, uid)
            }
        }
    }
    
    func updateImageUrl(_ uid: String, _ url: String) {
        let imageRef = db.collection("users").document(uid)

        // Set the url
        imageRef.updateData([
            "imageLink": url
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fetchData(_ completion: @escaping (String) ->Void) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            print("fetch data")
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.users = documents.map { queryDocumentSnapshot -> User in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let imageLink = data["imageLink"] as? String ?? ""
                let location = data["location"] as? GeoPoint
                let isFoodSelected = data["isFoodActive"] as? Bool ?? false
                
                let lang = location?.latitude ?? 0
                let long = location?.longitude ?? 0
                self.testUserId = id
                return User(name: name, imageLink: imageLink, lang: lang, long: long, id: id, isFoodSelected: isFoodSelected)
            }
            completion("Hallo")
        }
    }
}

