//
//  AppSettingsViewModel.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import Foundation
import Firebase

class AppSettingsViewModel: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var user: User?
    @Published var testUserId: String?
    
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn"){
        didSet {
            UserDefaults.standard.set(self.isLoggedIn, forKey: "isLoggedIn")
            NotificationCenter.default.post(name: NSNotification.Name("isLoggedInChange"), object: nil)
        }
    }
    
    @Published var isLoading: Bool = UserDefaults.standard.bool(forKey: "isLoading"){
        didSet {
            UserDefaults.standard.set(self.isLoading, forKey: "isLoading")
            NotificationCenter.default.post(name: NSNotification.Name("isLoadingChange"), object: nil)
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
    
    @Published var showNewUserName: Bool = UserDefaults.standard.bool(forKey: "showNewUserName"){
        didSet {
            UserDefaults.standard.set(self.showNewUserName, forKey: "showNewUserName")
            NotificationCenter.default.post(name: NSNotification.Name("showNewUserNameChange"), object: nil)
        }
    }
    
    @Published var userId: String = UserDefaults.standard.string(forKey: "userId") ?? "" {
        didSet {
            UserDefaults.standard.set(self.userId, forKey: "userId")
            NotificationCenter.default.post(name: NSNotification.Name("userIdChange"), object: nil)
        }
    }
    
    @Published var selectedPage: String = UserDefaults.standard.string(forKey: "selectedPage") ?? "login" {
        didSet {
            UserDefaults.standard.set(self.selectedPage, forKey: "selectedPage")
            NotificationCenter.default.post(name: NSNotification.Name("selectedPageChange"), object: nil)
        }
    }
    
    @Published var username: String = UserDefaults.standard.string(forKey: "username") ?? "" {
        didSet {
            UserDefaults.standard.set(self.username, forKey: "username")
            NotificationCenter.default.post(name: NSNotification.Name("usernameChange"), object: nil)
        }
    }
    
    @Published var password: String = UserDefaults.standard.string(forKey: "password") ?? "" {
        didSet {
            UserDefaults.standard.set(self.password, forKey: "password")
            NotificationCenter.default.post(name: NSNotification.Name("passwordChange"), object: nil)
        }
    }
    
//    func signUpLight(_ email: String, _ password: String, completion: @escaping (Bool)->Void) {
//    }
    
    // SignUp
    func signUp(_ email: String, _ password: String, completion: @escaping (Bool)->Void) {
        self.isLoading = true
        // Authenticate
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            // If ERROR
            if error != nil {
                self.isLoading = false
                completion(true)
            }
            
            let uid = (authResult?.user.uid) ?? ""
            self.testUserId = "xxdx"
            if uid != "" {
                self.userId = uid
                print("UID: \(String(describing: authResult?.user.uid))")
                let docRef = self.db.collection("users").document(uid)
                docRef.getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        let dataDescription = data.map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                        
                        let id = data!["id"] as? String ?? ""
                        let name = data!["name"] as? String ?? ""
                        let imageLink = data!["imageLink"] as? String ?? ""
                        let location = data!["location"] as? GeoPoint
                        let isFoodSelected = data!["isFoodSelected"] as? Bool ?? false
                        let lang = location?.latitude ?? 0
                        let long = location?.longitude ?? 0
                        self.user = User(name: name, imageLink: imageLink, lang: lang, long: long, id: id, isFoodSelected: isFoodSelected)
                        print("User: \(self.user!.name)")

                        //                        set values to logged in
                        self.isLoggedIn = true
                        self.showLogin = false
                        self.showRegister = false
                        self.isLoading = false
                        self.username = email
                        self.password = password
                        
//                        let user = User(name: name, imageLink: imageLink, lang: lang, long: long, id: id)
                    } else {
                        self.showNewUserName = true
                        self.isLoading = false
                        self.selectedPage = "selectName"
                        print("Document does not exist")
                    }
                }
                
            } else {
                self.isLoading = false
                print("not logged in")
            }
            completion(true)
           
        }
//        return (self.currentUserUid)
    }
    
    // SignIn
    func signIn(_ email: String, _ password: String, completion: @escaping (Bool)->Void) {
        self.isLoading = true
        // Authenticate
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            // If ERROR
            if error != nil {
                self.isLoading = false
                completion(true)
            }
            
            let uid = (authResult?.user.uid) ?? ""
            
            if uid != "" {
                self.userId = uid
                print("UID: \(authResult?.user.uid)")
                let docRef = self.db.collection("users").document(uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                        
                        let id = data!["id"] as? String ?? ""
                        let name = data!["name"] as? String ?? ""
                        let imageLink = data!["imageLink"] as? String ?? ""
                        let location = data!["location"] as? GeoPoint
                        let lang = location?.latitude ?? 0
                        let long = location?.longitude ?? 0
                        let isFoodSelected = data!["isFoodSelected"] as? Bool ?? false
                        
//                        print("User: \(self.user!.name ?? "nope")")
                        self.user = User(name: name, imageLink: imageLink, lang: lang, long: long, id: id, isFoodSelected: isFoodSelected)
                        print("User: \(self.user!.name)")

                        
                        //                        set values to logged in
                        self.isLoggedIn = true
                        self.showLogin = false
                        self.showRegister = false
                        self.isLoading = false
                        self.username = email
                        self.password = password
                    } else {
                        self.showNewUserName = true
                        self.isLoading = false
                        self.selectedPage = "selectName"
                        print("Document does not exist")
                    }
                }
                
            } else {
                self.isLoading = false
                print("not logged in")
            }
            completion(true)
           
        }
//        return (self.currentUserUid)
    }
    
    // Logout
    func logout() {
        try! Auth.auth().signOut()
        self.isLoggedIn = false
    }
    
    func getUserForUserId(_ uid: String, completion: @escaping (Bool)->Void) {
        
    }
    
}
