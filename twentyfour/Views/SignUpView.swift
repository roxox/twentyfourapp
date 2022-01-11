//
//  SignUpView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    @State var showNewUserName = UserDefaults.standard.value(forKey: "showNewUserName") as? Bool ?? false
    @State var isLoading = UserDefaults.standard.value(forKey: "isLoading") as? Bool ?? false
    
    @State var selectedPage = UserDefaults.standard.value(forKey: "selectedPage") as? String ?? "register"
    
    @State var newUserName: String = "Basti"
//    @State var newUserName: String = "Sebastian"
//    @State var newUserName: String = "Mira"
//    @State var newUserName: String = "Caro"
//    @State var newUserName: String = "Katharina"
//    @State var newUserName: String = "Katha"
//    @State var newUserName: String = "Michi"
    @State var imagedata : Data = .init(count: 0)
    
    
    
    func abort() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showLogin = false
            hideKeyboard()
        }
    }
    
    func back() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showNewUserName = false
            hideKeyboard()
        }
    }
    
    @ViewBuilder func getView() -> some View {
       switch selectedPage {
//       case "login": AnyView(SignInViewFirstStep())
//       case "login": AnyView(SignUpViewFirstStep(isEmailSelected: $isLoading))
       case "selectName": AnyView(SignInViewSecondStep(newUserName: $newUserName))
       case "selectPhoto": AnyView(SignInViewThirdStep(newUserName: $newUserName,
                                                       imagedata: $imagedata))
       default:
        AnyView(SignInViewFirstStep(isEmailSelected: $isLoading))
       }
    }
    
    var body: some View {
        VStack() {
            //            Rectangle().fill(Color.clear).frame(height: 150)
            
            Spacer()
            HStack() {
                Spacer()
                VStack() {
                    
                    // For testing
                    if isLoading {
                        SignInViewLoading()
                    } else {
                        
                        // Get View
                        self.getView()
                    
//                        if !showNewUserName {
//                            SignInViewFirstStep()
//                            //                            SignInViewSelection()
//                        } else {
//                            SignInViewSecondStep()
//                        }
                    }
                }
            }
//            .background(Color.white)
            .background(Color ("primary_back"))
            .cornerRadius(0)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("showNewUserNameChange"), object: nil, queue: .main) { (_) in
                    let showNewUserName = UserDefaults.standard.value(forKey: "showNewUserName") as? Bool ?? false
                    self.showNewUserName = showNewUserName
                }
                NotificationCenter.default.addObserver(forName: NSNotification.Name("isLoadingChange"), object: nil, queue: .main) { (_) in
                    let isLoading = UserDefaults.standard.value(forKey: "isLoading") as? Bool ?? false
                    self.isLoading = isLoading
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("selectedPageChange"), object: nil, queue: .main) { (_) in
                    let selectedPage = UserDefaults.standard.value(forKey: "selectedPage") as? String ?? "register"
                    self.selectedPage = selectedPage
                }
                
            }
            .cornerRadius(15)
        }
        
    }
}

struct SignUpViewSelection: View {
    func showEmailLogin() {
        print("Email")
    }
    var body: some View {
        VStack() {
            
            
            Button(action: showEmailLogin) {
                HStack() {
                    Spacer()
                    Text("E-Mail-Adresse")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color .black, lineWidth: 1))
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 8)
            .padding(.top, 40)
            
            Button(action: showEmailLogin) {
                HStack() {
                    Spacer()
                    Text("Facebook")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color .black, lineWidth: 1))
            .padding(.bottom, 8)
            .padding(.horizontal, horizontalPadding)
            
            Button(action: showEmailLogin) {
                HStack() {
                    Spacer()
                    Text("Google")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color .black, lineWidth: 1))
            .padding(.bottom, 8)
            .padding(.horizontal, horizontalPadding)
            
            Button(action: showEmailLogin) {
                HStack() {
                    Spacer()
                    Text("Apple")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color .black, lineWidth: 1))
            .padding(.horizontal, horizontalPadding)
            
            
            HStack() {
                Text("Mit deiner Anmeldung oder Erstellung eines Kontos stimmst du unseren Nutzungsbedingungen zu. In unseren Datenschutz- und Cookies-Richtlinien erfährst du mehr darüber, wie wir deine Daten verarbeiten")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    
                    .lineLimit(4)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
        }
    }
}

struct SignUpViewFirstStep: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    //    For Testing
//    @State var username = "basti@roxox.de"
//    @State var password = "basti123"
    
    @State var username = "sebastian.fox@me.com"
    @State var password = "audiR8GTx.3"
    
//    @State var username = "mira.fox@roxox.de"
//    @State var password = "Mira123"
    
//    @State var username = "caro.fox@roxox.de"
//    @State var password = "Caro123"
    
//    @State var username = "katharina.fox@roxox.de"
//    @State var password = "Katharina123"
    
//    @State var username = "katha.fox@roxox.de"
//    @State var password = "Katha123"
    
//    @State var username = "michi.fox@roxox.de"
//    @State var password = "Michi123"
    
//    @State var username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
//    @State var password = UserDefaults.standard.value(forKey: "password") as? String ?? ""
    
    @State private var isUsernameFocused = false
    
    func signUp() {
        appSettingsViewModel.signUp(self.username, self.password) { completion in
            //            completion
        }
    }
    
    func abort() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showLogin = false
            appSettingsViewModel.showRegister = false

            hideKeyboard()
        }
    }
    
    var body: some View {
        VStack() {
            HStack() {
                VStack(alignment: .leading) {
                    Button(action: abort) {
                        Image(systemName: "xmark")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color ("primary_text"))
                            .padding(.top, 25)
                        
                    }
                    .padding(.trailing, 10)
                    
                    Text("Registriere dich und finde unternimm etwas zusammen")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                }
                Spacer()
                
                
            }
            .padding(.horizontal, horizontalPadding)
            
            HStack() {
                Text("E-Mail-Adresse")
                    .font(.system(size: 13))
                    .fontWeight(.light)
                    .padding(.top, 35)
                //                    .foregroundColor(username == "" ? .white : .black)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            
            ZStack() {
                RoundedRectangle(cornerRadius: 8).fill(Color (.white)).frame(height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color ("gray"), lineWidth: 1))
                
                TextField("meine@email.de", text: self.$username)
                    
                        .font(Font.system(size: 18, weight: .thin))
                    .keyboardType(.alphabet)
                    .accentColor(Color ("primary_text"))
                    .padding(.horizontal, horizontalPadding)
                    .foregroundColor(Color ("black"))
                    
                //                    .focusable(true) { newState in isUsernameFocused = newState }
            }
            .padding(.horizontal, horizontalPadding)
            
            //            Divider()
            //                .padding(.horizontal, horizontalPadding)
            
            HStack() {
                Text("Passwort")
                    .font(.system(size: 13))
                    .fontWeight(.light)
                //                    .foregroundColor(password == "" ? .white : .black)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 12)
            
            
            ZStack() {
                RoundedRectangle(cornerRadius: 8).fill(Color (.white)).frame(height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color ("gray"), lineWidth: 1))
                
                SecureField("#$%&?Ä", text: self.$password)
                    .font(Font.system(size: 18, weight: .thin))
                    .keyboardType(.alphabet)
                    .accentColor(Color ("primary_text"))
                    .padding(.horizontal, horizontalPadding)
//                    .background(Color (.white))
                    .foregroundColor(Color ("black"))
                
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 15)
            
            //            Divider()
            //                .padding(.horizontal, horizontalPadding)
            
            Button(action: signUp) {
                HStack() {
                    Spacer()
                    Text("Registrieren")
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(password != "" && username != "" ? Color.black : Color.white)
                    
                    Spacer()
                }
//                .background(password != "" && username != "" ? Color("mint") : Color("gray"))
//                .background(password != "" && username != "" ? Color("gray") : Color("gray"))
//                .background(gradientBlueMint)
                .background(password != "" && username != "" ? gradientBlueMint : gradientGray)
            }
            .disabled(!(password != "" && username != ""))
            .cornerRadius(8)
            .padding(.horizontal, horizontalPadding)
            
            .padding(.top, 10)
            //            .padding(.bottom, 50)
            
            
            HStack() {
                Text("Mit deiner Anmeldung oder Erstellung eines Kontos stimmst du unseren Nutzungsbedingungen zu. In unseren Datenschutz- und Cookies-Richtlinien erfährst du mehr darüber, wie wir deine Daten verarbeiten")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    
                    .lineLimit(4)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
        }
        .onAppear() {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("usernameChange"), object: nil, queue: .main) { (_) in
                let username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
                self.username = username
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("passwordChange"), object: nil, queue: .main) { (_) in
                let password = UserDefaults.standard.value(forKey: "password") as? String ?? ""
                self.password = password
            }
        }
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
