//
//  MaintenanceView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.09.21.
//

import SwiftUI
import Firebase
import FirebaseFirestore


/*
 
 var id: String?
 var name: String
 var imageLink: String
 var imagedata: Data = .init(count: 0)
 var isFoodSelected: Bool
 */

struct MaintenanceView: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @State var id: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = "basti123"
    @State var imageLink: String = ""
    @State var imagedata: Data = .init(count: 0)
    @State var isFoodSelected: Bool = true
    @State var picker = false
    @State var currentUserImageUrl: String = ""
    
    func reset() {
        id = ""
        username = ""
        email = ""
        password = "basti123"
        imageLink = ""
        imagedata = .init(count: 0)
        isFoodSelected = true
        picker = false
        currentUserImageUrl = ""
    }
    func createUser() {
//        appSettingsViewModel.signUp(email, password)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            // If ERROR
            if error != nil {
                print("ERROR SIGNING UP")
            }
            
            let uid = (authResult?.user.uid) ?? ""
            print("User ID: \(uid)")
            id = uid
            
        }
    }
    
    
    func addNewUserProfileImage(_ data: Data, _ uid: String, _ name: String) {
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
                    print("ERROR")
                    // Uh-oh, an error occurred!
                    return
                }
                self.currentUserImageUrl = downloadURL.absoluteString
                print(self.currentUserImageUrl)
                self.addNewUserFromData(name, downloadURL.absoluteString, uid)
            }
        }
    }
    
    func addNewUserFromData(_ name: String, _ imageLing: String, _ id: String) {
        do {
            let uid = Auth.auth().currentUser?.uid
            let newUser = User(name: name, imageLink: imageLing, lang: 0, long: 0, id: uid, isFoodSelected: isFoodSelected)
            try db.collection("users").document(newUser.id!).setData(newUser.representation) { _ in
                print("NEW PROFILE OK")
                self.reset()
                
            }
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Group() {
                    Rectangle().fill(Color.clear).frame(height: 60)
                    Text("Email")
                        .fontWeight(.bold)
                    TextField("E-Mail-Adresse", text: self.$email)
                        .padding(.bottom, 10)
                    
                    Text("Password")
                        .fontWeight(.bold)
                    TextField("Password", text: self.$password)
                        .padding(.bottom, 10)
                    
                    Button(action: {
                        self.createUser()
                        
                    }) {
                        Text("User anlegen")
                    }
                    .padding(.bottom, 10)
                    .disabled(id != "")
                    
                    Divider()
                        .padding(.bottom, 10)
                }
                if id != "" {
                Group() {
                    HStack() {
                        Spacer()
                        Button(action: {
                            self.picker.toggle()
                            
                        }) {
                            if self.imagedata.count == 0{
                                VStack() {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 90)
                                        .foregroundColor(Color("gray"))
                                        .padding(.bottom)
                                    
                                    Text("Wähle dein Profilfoto")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                        .fontWeight(.bold)
                                        .underline()
                                }
                            }
                            else{
                                Image(uiImage: UIImage(data: self.imagedata)!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .clipShape(Circle())
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    Text("Name")
                        .fontWeight(.bold)
                    
                    TextField("Username", text: self.$username)
                        .padding(.bottom, 10)
                    
                    Toggle("Food Selection", isOn: $isFoodSelected)
                    
                    Button(action: {
                        self.addNewUserProfileImage(imagedata, id, username)
                        
                    }) {
                        Text("User Profil anlegen")
                    }
                    .padding(.bottom, 10)
                }
                }
            }
            .padding(.horizontal, horizontalPadding)
            .sheet(isPresented: self.$picker, content: {
                ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
            })
        }
        .navigationBarHidden(false)
        .navigationBarTitle("MAINT NEW USER", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}

struct MaintenanceView_Previews: PreviewProvider {
    static var previews: some View {
        MaintenanceView()
    }
}
