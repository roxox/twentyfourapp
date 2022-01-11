//
//  SignInView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    @State var showNewUserName = UserDefaults.standard.value(forKey: "showNewUserName") as? Bool ?? false
    @State var isLoading = UserDefaults.standard.value(forKey: "isLoading") as? Bool ?? false
    
    @State var selectedPage = UserDefaults.standard.value(forKey: "selectedPage") as? String ?? "login"
    
    @State var newUserName: String = "Basti"
    //    @State var newUserName: String = "Sebastian"
    //    @State var newUserName: String = "Mira"
    //    @State var newUserName: String = "Caro"
    //    @State var newUserName: String = "Katharina"
    //    @State var newUserName: String = "Katha"
    @State var imagedata : Data = .init(count: 0)
    
    @State var isEmailSelected: Bool = false
    
    
    
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
        case "login": AnyView(SignInViewFirstStep(isEmailSelected: $isEmailSelected))
        case "selectName": AnyView(SignInViewSecondStep(newUserName: $newUserName))
        case "selectPhoto": AnyView(SignInViewThirdStep(newUserName: $newUserName,
                                                        imagedata: $imagedata))
        default:
            AnyView(SignInViewFirstStep(isEmailSelected: $isEmailSelected))
        }
    }
    
    var body: some View {
        VStack() {
            //            Rectangle().fill(Color.clear).frame(height: 150)
            
            //            Spacer()
            HStack() {
//                Spacer()
                VStack() {
                    
                    // For testing
                    if isLoading {
                        SignInViewLoading()
                    } else {
                        
                        // Get View
//                        self.getView()
                        ZStack() {
                            SignInSelection(isEmailSelected: $isEmailSelected)
                                .offset(x: self.isEmailSelected ? -screenWidth : 0)
                            SignInViewFirstStep(isEmailSelected: $isEmailSelected)
                                .offset(x: self.isEmailSelected ? 0 : screenWidth)
                        }
                        
                    }
                }
            }
            //            Spacer()
            //            .background(Color.white)
            .background(Color ("primary_back"))
            .cornerRadius(25)
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
                    let selectedPage = UserDefaults.standard.value(forKey: "selectedPage") as? String ?? "login"
                    self.selectedPage = selectedPage
                }
                
            }
//            .cornerRadius(20)
            
            //            .navigationTitle("Finde Gleichgesinnte")
            //            .navigationBarHidden(true)
            //            .navigationBarBackButtonHidden(true)
            //            .navigationBarItems(leading:
            //                                    Button(action: {
            //                                        self.presentationMode.wrappedValue.dismiss()
            //                                    }) {
            //                                        HStack {
            //                                            Image(systemName: "chevron.left")
            //                                                .font(Font.system(size: 20, weight: .bold))
            //                                                //                            Text("zurück")
            //                                                //                                .foregroundColor(.black)
            //                                                .foregroundColor(Color ("primary_text"))
            //                                                .padding()
            //                                                .offset(x: -15)
            //                                        }
            //                                    })
        }
        
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}

struct SignInSelection: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    @State private var addSpacerValue = false
    
    @Binding var isEmailSelected: Bool
    
    func addSpacer() {
        self.addSpacerValue.toggle()
    }
    
    func selectEmail() {
        withAnimation(.linear(duration: 0.3)) {
            isEmailSelected = true
            hideKeyboard()
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
        VStack(alignment: .leading) {
            //                VStack(alignment: .trailing) {
            HStack() {
                Spacer()
                Button(action: abort) {
                    Image(systemName: "xmark")
                        //                            .font(.system(size: 18))
                        .font(Font.system(size: 26, weight: .semibold))
                        .foregroundColor(Color ("primary_text"))
                        .padding(.top, 20)

                }
            }
            
            Text("Greifen Sie auf Top-Tipps auf Twentyfour zu")
                .font(.system(size: 32))
                .padding(.top, 25)
            //                            .padding(.horizontal, horizontalPadding)
//
            Text("Speichern Sie von Reisenden empfohlene Ideen, nutzen Sie Preisbenachrichtigungen und mehr.")
                .font(.system(size: 16))
                .padding(.top, 25)
                //                        .padding(.horizontal, horizontalPadding)
                //                }
                .padding(.bottom, 15)
            
            
            Button(action: selectEmail) {
                HStack() {
                    Image("mail")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 20)
                        .foregroundColor(.black)
                    Spacer()
                    Text("Mit E-Mail fortfahren")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color ("primary_text"))
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
//            .padding(.bottom, 8)
            .padding(.top, 10)
            
            Button(action: addSpacer) {
                HStack() {
                    Image("apple")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 20)
                        .foregroundColor(.black)
                    Spacer()
                    Text("Mit Apple fortfahren")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color ("primary_text"))
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
//            .padding(.bottom, 8)
            .padding(.top, 10)
            
            
            Button(action: addSpacer) {
                HStack() {
                    Image("facebook")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 20)
                        .foregroundColor(Color ("blue-1"))
                    Spacer()
                    Text("Mit Facebook fortfahren")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color ("primary_text"))
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
//            .padding(.bottom, 8)
            .padding(.top, 10)
            
            
            Button(action: addSpacer) {
                HStack() {
                    Image("google")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 20)
                        .foregroundColor(.red)
                    Spacer()
                    Text("Mit Google fortfahren")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color ("primary_text"))
                    
                    Spacer()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
//            .padding(.bottom, 8)
            .padding(.top, 10)
            
            Spacer()
            
            
            HStack() {
                Text("Mit deiner Anmeldung oder Erstellung eines Kontos stimmst du unseren Nutzungsbedingungen zu. In unseren Datenschutz- und Cookies-Richtlinien erfährst du mehr darüber, wie wir deine Daten verarbeiten")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)

                    .lineLimit(4)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
            }
            
        }
        .padding(.horizontal, horizontalPadding)
        .onAppear() {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("usernameChange"), object: nil, queue: .main) { (_) in
                let username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
//                self.username = username
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("passwordChange"), object: nil, queue: .main) { (_) in
                let password = UserDefaults.standard.value(forKey: "password") as? String ?? ""
//                self.password = password
            }
        }
    }
}

struct SignInViewFirstStep: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    @Binding var isEmailSelected: Bool
    
    //    For Testing
    @State var username = "basti@roxox.de"
    @State var password = "basti123"
    
    //            @State var username = "sebastian.fox@me.com"
    //        @State var password = "audiR8GTx.3"
    //    @State var username = ""
    //    @State var password = ""
    
    //    @State var username = "mira.fox@roxox.de"
    //    @State var password = "Mira123"
    
    //    @State var username = "caro.fox@roxox.de"
    //    @State var password = "Caro123"
    
    //        @State var username = "katharina.fox@roxox.de"
    //        @State var password = "Katharina123"
    
    //    @State var username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
    //    @State var password = UserDefaults.standard.value(forKey: "password") as? String ?? ""
    
    //    @State var username = "katha.fox@roxox.de"
    //    @State var password = "Katha123"
    
    @State private var isUsernameFocused = false
    @State private var isPasswordFocused = false
    @State private var addSpacerValue = false
    
    func signIn() {
        
        self.isPasswordFocused = false
        
        self.isUsernameFocused = false
        appSettingsViewModel.signIn(self.username, self.password) { completion in
            //            completion
        }
    }
    
    
    func back() {
        withAnimation(.linear(duration: 0.3)) {
            isEmailSelected = false
            hideKeyboard()
//            appSettingsViewModel.showLogin = false
//            appSettingsViewModel.showRegister = false
        }
    }
    
    func abort() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showLogin = false
            appSettingsViewModel.showRegister = false
            isPasswordFocused = false
            isUsernameFocused = false
            hideKeyboard()
        }
    }
    
    func unfocus() {
        isUsernameFocused = false
        isPasswordFocused = false
    }
    
    func addSpacer() {
        self.addSpacerValue.toggle()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //                VStack(alignment: .trailing) {
            HStack() {
                Button(action: back) {
                    Image(systemName: "chevron.left")
                        //                            .font(.system(size: 18))
                        .font(Font.system(size: 26, weight: .semibold))
                        .foregroundColor(Color ("primary_text"))
                        .padding(.top, 20)

                }
                Spacer()
            }
            
            Text("Wilkommen (zurück)!\nLogge dich wieder ein")
                .font(.system(size: 32))
                .padding(.top, 10)
            //                            .padding(.horizontal, horizontalPadding)
//
            HStack() {
            Text("Du hast noch keine Konto?")
            Text("Dann meld registriere dich hier")
                .fontWeight(.bold)
                .underline()
            }
            .font(.system(size: 11))
                .padding(.top, 25)
                //                        .padding(.horizontal, horizontalPadding)
                //                }
                .padding(.bottom, 25)
            
            
//            Button(action: addSpacer) {
//                HStack() {
//                    Image("mail")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(.black)
//                    Spacer()
//                    Text("Mit E-Mail fortfahren")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .padding()
//                        .foregroundColor(Color ("primary_text"))
//
//                    Spacer()
//                }
//            }
//            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
//            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
////            .padding(.bottom, 8)
//            .padding(.top, 10)
//
//            Button(action: addSpacer) {
//                HStack() {
//                    Image("apple")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(.black)
//                    Spacer()
//                    Text("Mit Apple fortfahren")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .padding()
//                        .foregroundColor(Color ("primary_text"))
//
//                    Spacer()
//                }
//            }
//            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
//            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
////            .padding(.bottom, 8)
//            .padding(.top, 10)
//
//
//            Button(action: addSpacer) {
//                HStack() {
//                    Image("facebook")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(Color ("blue-1"))
//                    Spacer()
//                    Text("Mit Facebook fortfahren")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .padding()
//                        .foregroundColor(Color ("primary_text"))
//
//                    Spacer()
//                }
//            }
//            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
//            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
////            .padding(.bottom, 8)
//            .padding(.top, 10)
//
//
//            Button(action: addSpacer) {
//                HStack() {
//                    Image("google")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .padding(.leading, 20)
//                        .foregroundColor(.red)
//                    Spacer()
//                    Text("Mit Google fortfahren")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .padding()
//                        .foregroundColor(Color ("primary_text"))
//
//                    Spacer()
//                }
//            }
//            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
//            .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
////            .padding(.bottom, 8)
//            .padding(.top, 10)
//
//            Spacer()
            
            
            
                        ZStack() {
            
                            VStack() {
            
                                ZStack(){
            
                                    RoundedRectangle(cornerRadius: 5).fill(Color ("gray-3")).frame(height: 48)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("gray-2"), lineWidth: 1))
            
                                    TextField("E-Mail-Adresse", text: self.$username)
                                        .font(.system(size: 17))
                                        .accentColor(Color ("black"))
                                        .keyboardType(.alphabet)
                                        .accentColor(Color ("primary_text"))
                                        .background(Color.clear)
            
            
                                        .padding(.horizontal, horizontalPadding)
                                        .foregroundColor(Color ("black"))
            //                            .offset(y: (username != "" || isUsernameFocused)  ? -9 : -2)
                                        .onTapGesture {
                                            self.isPasswordFocused = false
                                            self.isUsernameFocused = true
                                        }
            
                                }
                                .padding(.vertical)
                                .frame(height: 48)
//                                .padding(.horizontal, horizontalPadding)
                                .padding(.bottom, 10)
            
            //                    Rectangle().fill(!isUsernameFocused && !isPasswordFocused ?  Color("gray-2") : Color.clear).frame(height: 1).frame(maxWidth: .infinity)
            //                        .padding(.horizontal, horizontalPadding)
            
                                ZStack(){
            
                                    RoundedRectangle(cornerRadius: 5).fill(Color ("gray-3")).frame(height: 48)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("gray-2"), lineWidth: 1))
            //                            .padding(.horizontal, horizontalPadding)
            
                                    VStack(){
                                        Spacer()
                                    SecureField("Passwort", text: self.$password)
                                        //                    .font(Font.system(size: 17, weight: .medium))
                                        .font(.system(size: 17))
                                        .accentColor(Color ("black"))
                                        .keyboardType(.alphabet)
                                        .accentColor(Color ("primary_text"))
                                        .padding(.horizontal, horizontalPadding)
                                        .foregroundColor(Color ("black"))
            //                            .offset(y: (password != "" || isPasswordFocused) ? -9 : -2)
                                        .onTapGesture {
                                            self.isPasswordFocused = true
                                            self.isUsernameFocused = false
                                        }
                                        Spacer()
                                    }
                                }
            
            //                    .padding(.top, 10)
                                .frame(height: 48)
//                                .padding(.horizontal, horizontalPadding)
                            }
                            .zIndex(0)
            
            //                if isUsernameFocused || isPasswordFocused {
            //                    VStack() {
            //                        RoundedRectangle(cornerRadius: 8).fill(Color (.clear)).frame(height: 56)
            //                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 3))
            //                            .padding(.horizontal, horizontalPadding)
            //                            .offset(y: isUsernameFocused ? -30 : 30)
            //                    }
            //                }
                        }
                        .padding(.bottom, 10)
            
            Spacer()
                            Button(action: signIn) {
                                HStack() {
                                    Spacer()
                                    Text("Anmelden")
                                        .font(.system(size: 19))
                                        .fontWeight(.semibold)
                                        .padding()
                                        .foregroundColor(Color(.black).opacity(password != "" && username != "" ? 1 : 0.9))
            //                            .animation()
            
                                    Spacer()
                                }
            //                    .background(Color("blue-1").opacity(password != "" && username != "" ? 1 : 0.1))
                                .background(Color(.white).opacity(password != "" && username != "" ? 1 : 0.05))
                                
                                .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
                                .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
                                
            //                    .background(gradientBlueMint.opacity(password != "" && username != "" ? 1 : 0.1))
            //                    .animation(.easeInOut(duration: 0))
            //                                        .background(password != "" && username != "" ? gradientBlueMint : gradientGray)
                                //                gradientPeachOrange
                            }
                            .disabled(!(password != "" && username != ""))
                            .cornerRadius(buttonCornerRadius)
//                            .padding(.horizontal, horizontalPadding)
            
//            Spacer()
            
            
            //            Group() {
            //                Button(action: signIn) {
            //                    HStack() {
            //                        Spacer()
            //                        Text("Anmelden")
            //                            .font(.system(size: 19))
            //                            .fontWeight(.semibold)
            //                            .padding()
            //                            .foregroundColor(Color(.white).opacity(password != "" && username != "" ? 1 : 0.9))
            ////                            .animation()
            //
            //                        Spacer()
            //                    }
            ////                    .background(Color("blue-1").opacity(password != "" && username != "" ? 1 : 0.1))
            //                    .background(Color("black").opacity(password != "" && username != "" ? 1 : 0.05))
            ////                    .background(gradientBlueMint.opacity(password != "" && username != "" ? 1 : 0.1))
            ////                    .animation(.easeInOut(duration: 0))
            ////                                        .background(password != "" && username != "" ? gradientBlueMint : gradientGray)
            //                    //                gradientPeachOrange
            //                }
            //                .disabled(!(password != "" && username != ""))
            //                .cornerRadius(buttonCornerRadius)
            //                .padding(.horizontal, horizontalPadding)
            //
            //                //                .padding(.top, 10)
            //
            //                Group() {
            //                    HStack() {
            //                        VStack() {
            //                            Divider()
            //                        }
            //                        Text("ODER")
            //                            .font(.system(size: 13))
            //                            .fontWeight(.medium)
            //                            .foregroundColor(Color("gray-2"))
            //                            .padding(.vertical)
            //
            //                        VStack() {
            //                            Divider()
            //                        }
            //                    }
            //                    .padding(.horizontal, horizontalPadding)
            //
            //                    Button(action: unfocus) {
            //                        HStack() {
            //                            Image("apple")
            //                                .resizable()
            //                                .frame(width: 25, height: 25)
            //                                .padding(.leading, 20)
            //                                //                            Divider()
            //                                .frame(height: 30)
            //                            Spacer()
            //                            Text("Mit Apple fortfahren")
            //                                .font(.system(size: 16))
            //                                .fontWeight(.semibold)
            //                                .padding()
            //                                .foregroundColor(Color ("primary_text"))
            //
            //                            Spacer()
            //                        }
            //                    }
            //                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            //                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
            //                    //            .padding(.bottom, 8)
            //                    .padding(.horizontal, horizontalPadding)
            //                    .padding(.top, 10)
            //
            //
            //                    Button(action: signIn) {
            //                        HStack() {
            //                            Image("facebook")
            //                                .renderingMode(.template)
            //                                .resizable()
            //                                .frame(width: 25, height: 25)
            //                                .padding(.leading, 20)
            //                                //                            Divider()
            //                                .frame(height: 30)
            //                            Spacer()
            //                            Text("Mit Facebook fortfahren")
            //                                .font(.system(size: 16))
            //                                .fontWeight(.semibold)
            //                                .padding()
            //                                .foregroundColor(Color ("primary_text"))
            //                                .foregroundColor(.blue)
            //
            //                            Spacer()
            //                        }
            //                    }
            //                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            //                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
            //                    //            .padding(.bottom, 8)
            //                    .padding(.horizontal, horizontalPadding)
            //                    .padding(.top, 10)
            //
            //
            //                    Button(action: addSpacer) {
            //                        HStack() {
            //                            Image("google")
            //                                .renderingMode(.template)
            //                                .resizable()
            //                                .frame(width: 25, height: 25)
            //                                .padding(.leading, 20)
            //                                .foregroundColor(.red)
            //                            Spacer()
            //                            Text("Mit Google fortfahren")
            //                                .font(.system(size: 16))
            //                                .fontWeight(.semibold)
            //                                .padding()
            //                                .foregroundColor(Color ("primary_text"))
            //
            //                            Spacer()
            //                        }
            //                    }
            //                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            //                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
            //                    .padding(.bottom, 8)
            //                    .padding(.horizontal, horizontalPadding)
            //                    .padding(.top, 10)
            //                }
            //                //            .padding(.bottom, 50)
            //            }
            
            //            Spacer()
            
            HStack() {
                Text("Mit deiner Anmeldung oder Erstellung eines Kontos stimmst du unseren Nutzungsbedingungen zu. In unseren Datenschutz- und Cookies-Richtlinien erfährst du mehr darüber, wie wir deine Daten verarbeiten")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)

                    .lineLimit(4)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
            }
//            .padding(.horizontal, horizontalPadding)
            
        }
        .padding(.horizontal, horizontalPadding)
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

struct SignInViewSecondStep: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    @ObservedObject var usersViewModel = UsersViewModel()
    
    
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    //    @State var name = "Basti"
    @State var imagedata : Data = .init(count: 0)
    @State var picker = false
    
    @Binding var newUserName: String
    
    func addNewUser() {
        usersViewModel.addNewUserFromData(newUserName, "empty", userId)
    }
    
    
    func back() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showRegister = false
            appSettingsViewModel.showLogin = true
            appSettingsViewModel.selectedPage = "login"
            hideKeyboard()
        }
    }
    
    func next() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.selectedPage = "selectPhoto"
            hideKeyboard()
        }
    }
    
    var body: some View {
        VStack() {
            
            HStack() {
                VStack(alignment: .leading) {
                    Button(action: back) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 25)
                        
                    }
                    .padding(.trailing, 10)
                    
                    Text("Da wir kein Profil für dich gefunden haben, legen wir eben eins an.")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                }
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            
            HStack() {
                Text("Schritt 1/3 \nWie heißt du?")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 10)
            
            
            //            HStack() {
            //                Text("NAME")
            //                    .font(.system(size: 14))
            //                    .fontWeight(.bold)
            //                Spacer()
            //            }
            //            .padding(.horizontal, horizontalPadding)
            //            .padding(.top, 35)
            //
            //            ZStack() {
            //                RoundedRectangle(cornerRadius: 8).fill(Color.white).frame(height: 45)
            //                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color .black, lineWidth: 3))
            //                TextField("Name", text: self.$newUserName)
            //                    .font(Font.system(size: 18, weight: .semibold))
            //                    .keyboardType(.alphabet)
            //                    .background(Color.white)
            //                    .padding(.horizontal, horizontalPadding)
            //            }
            //            .padding(.horizontal, horizontalPadding)
            //            .padding(.bottom, 15)
            
            
            ZStack(){
                
                RoundedRectangle(cornerRadius: 5).fill(Color ("gray-3")).frame(height: 48)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("gray-2"), lineWidth: 1))
                
                TextField("Name", text: self.$newUserName)
                    .font(.system(size: 17))
                    .accentColor(Color ("black"))
                    .keyboardType(.alphabet)
                    .accentColor(Color ("primary_text"))
                    .background(Color.clear)
                    
                    
                    .padding(.horizontal, horizontalPadding)
                    .foregroundColor(Color ("black"))
                
            }
            .frame(height: 48)
            .padding(.top, 35)
            .padding(.vertical)
            .padding(.horizontal, horizontalPadding)
            
            
            Button(action: next) {
                HStack() {
                    Spacer()
                    Text("Anmelden")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color(.white).opacity(newUserName != "" ? 1 : 0.5))
                    
                    Spacer()
                }
                //                    .background(Color("blue-1").opacity(newUserName != "" ? 1 : 0.3))
                .background(Color("black").opacity(newUserName != "" ? 1 : 0.3))
                //                                        .background(password != "" && username != "" ? gradientBlueMint : gradientGray)
                //                gradientPeachOrange
            }
            .disabled(!(newUserName != ""))
            .cornerRadius(8)
            .padding(.horizontal, horizontalPadding)
            
            //            Button(action: next) {
            //                HStack() {
            //                    Spacer()
            //                    Text("Weiter")
            //                        .font(.system(size: 19))
            //                        .fontWeight(.semibold)
            //                        .padding()
            //                        .foregroundColor(newUserName != "" ? Color.white : Color.white)
            //
            //                    Spacer()
            //                }
            //                .background(newUserName != "" ? Color("black") : Color("gray"))
            //            }
            //            .cornerRadius(8)
            //            .padding(.horizontal, horizontalPadding)
            //            .padding(.top, 10)
            //            .padding(.bottom, 50)
            
            HStack() {
                Text("Mit deiner Anmeldung oder Erstellung eines Kontos stimmst du unseren Nutzungsbedingungen zu. In unseren Datenschutz- und Cookies-Richtlinien erfährst du mehr darüber, wie wir deine Daten verarbeiten")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    
                    .lineLimit(4)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                //                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            
        }
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
        })
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("userIdChange"), object: nil, queue: .main) { (_) in
                let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
                self.userId = userId
            }
        }
    }
}


struct SignInViewThirdStep: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    @ObservedObject var usersViewModel = UsersViewModel()
    
    
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    //    @State var name = "Basti"
    //    @State var imagedata : Data = .init(count: 0)
    @State var picker = false
    
    @Binding var newUserName: String
    @Binding var imagedata: Data
    
    func addNewUser() {
        usersViewModel.addNewUserFromData(newUserName, "empty", userId)
    }
    
    func addNewUserProfileImage() {
        usersViewModel.addNewUserProfileImage(imagedata, userId, newUserName)
    }
    
    
    func back() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.selectedPage = "selectName"
            //            hideKeyboard()
        }
    }
    
    //    func next() {
    //        withAnimation(.linear(duration: 0.4)) {
    //            appSettingsViewModel.selectedPage = "selectPhoto"
    //            hideKeyboard()
    //        }
    //    }
    
    var body: some View {
        VStack() {
            
            HStack() {
                VStack(alignment: .leading) {
                    Button(action: back) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 25)
                        
                    }
                    .padding(.trailing, 10)
                    
                    Text("Hi \(newUserName), schön, dass du da bist. Weiter geht's!")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                }
                Spacer()
                
                
            }
            .padding(.horizontal, horizontalPadding)
            
            HStack() {
                Text("Schritt 2/3 \nWie siehst du aus?")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 10)
            
            HStack{
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
            .padding(.top, 40)
            .padding(.bottom, 15)
            
            
            Button(action: addNewUserProfileImage) {
                HStack() {
                    Spacer()
                    Text("Weiter")
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(newUserName != "" ? Color.white: Color.white)
                    
                    Spacer()
                }
                .background(newUserName != "" ? Color("black") : Color("gray"))
            }
            .cornerRadius(8)
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 10)
            
            Button(action: addNewUser) {
                HStack() {
                    Spacer()
                    Text("ohne Foto fortfahren")
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .underline()
                        //                        .padding()
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                //                .background(newUserName != "" ? Color("peach") : Color("gray"))
            }
            //            .cornerRadius(8)
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 10)
            
            
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
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imagedata: self.$imagedata)
        })
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("userIdChange"), object: nil, queue: .main) { (_) in
                let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
                self.userId = userId
            }
        }
    }
}

struct SignInViewLoading: View {
    var body: some View {
        Spacer()
        HStack() {
            Spacer()
            
            Text("Loading")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.vertical, 70)
            Spacer()
        }
        Spacer()
    }
}


enum SignInViewPages: CaseIterable {
    case login
    case selectName
    case selectPhoto
}

var gradientPeachOrange: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("pink"),
//                    .pink,
                    Color ("peach"),
//                    .pink,
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientSelected: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("pink"),
//                    .purple,
                    Color("blue"),
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientBlueMint: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("blue"),
                    //                    Color ("mint"),
                    Color ("mint")
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientVioletPurple: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet-1"),
                    //                    Color ("mint"),
                    Color.purple
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

func dynamicLinearGradient(colors: [Color]) -> LinearGradient {
    let gradient = LinearGradient(
        gradient: Gradient(
            colors:
                [
                    colors[0],
                    colors[1],
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    return gradient
}

var gradientBlueBlue: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("blue-1"),
                    //                    Color ("mint"),
                    Color ("blue")
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientBlueMintInvert: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    
                    Color ("mint"),
                    Color ("blue"),
                    //                    Color ("mint"),
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}


var gradientPurpleViolet: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    //                    Color ("mint"),
                    Color ("blue-1"),
                    Color ("turquoise"),
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientGray: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("gray")
                    //                    .gray
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}



struct SignInViewFirstStep_alternative: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    //    For Testing
    //    @State var username = "basti@roxox.de"
    //    @State var password = "basti123"
    
    //        @State var username = "sebastian.fox@me.com"
    //    @State var password = "audiR8GTx.3"
    
    @State var username = ""
    @State var password = ""
    
    //    @State var username = "mira.fox@roxox.de"
    //    @State var password = "Mira123"
    
    //    @State var username = "caro.fox@roxox.de"
    //    @State var password = "Caro123"
    
    //        @State var username = "katharina.fox@roxox.de"
    //        @State var password = "Katharina123"
    
    //    @State var username = UserDefaults.standard.value(forKey: "username") as? String ?? ""
    //    @State var password = UserDefaults.standard.value(forKey: "password") as? String ?? ""
    
    //    @State var username = "katha.fox@roxox.de"
    //    @State var password = "Katha123"
    
    @State private var isUsernameFocused = false
    @State private var isPasswordFocused = false
    @State private var addSpacerValue = false
    
    func signIn() {
        
        self.isPasswordFocused = false
        
        self.isUsernameFocused = false
        appSettingsViewModel.signIn(self.username, self.password) { completion in
            //            completion
        }
    }
    
    func abort() {
        withAnimation(.linear(duration: 0.4)) {
            appSettingsViewModel.showLogin = false
            appSettingsViewModel.showRegister = false
            isPasswordFocused = false
            isUsernameFocused = false
            hideKeyboard()
        }
    }
    
    func unfocus() {
        isUsernameFocused = false
        isPasswordFocused = false
    }
    
    func addSpacer() {
        self.addSpacerValue.toggle()
    }
    
    var body: some View {
        VStack() {
            HStack() {
                VStack(alignment: .leading) {
                    Button(action: abort) {
                        Image(systemName: "xmark")
                            //                            .font(.system(size: 18))
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundColor(Color ("primary_text"))
                        //                            .padding(.top, 20)
                        
                    }
                    
                    Text("Logge dich ein, und unternimm was mit anderen zusammen")
                        //                    Text("Los geht's")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .padding(.top, 25)
                }
                .padding(.vertical, 20)
                .padding(.top, 10)
                Spacer()
                
                
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 15)
            
            ZStack() {
                RoundedRectangle(cornerRadius: 8).fill(Color (.white)).frame(height: 116)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(isUsernameFocused ? Color("gray-2") : Color("gray-2"), lineWidth: isUsernameFocused ? 1 : 1))
                    .padding(.horizontal, horizontalPadding)
                
                VStack() {
                    
                    VStack(alignment: .leading){
                        
                        if username != "" || isUsernameFocused {
                            Text("E-Mail-Adresse")
                                .font(.system(size: 13))
                                .foregroundColor(Color("gray-1"))
                                .padding(.horizontal, horizontalPadding)
                        }
                        
                        TextField(self.isUsernameFocused ? "" : "E-Mail-Adresse", text: self.$username)
                            .font(.system(size: 17))
                            .accentColor(Color ("black"))
                            .keyboardType(.alphabet)
                            .accentColor(Color ("primary_text"))
                            .background(Color.clear)
                            
                            
                            .padding(.horizontal, horizontalPadding)
                            .foregroundColor(Color ("black"))
                            .offset(y: (username != "" || isUsernameFocused)  ? -9 : -2)
                            .onTapGesture {
                                self.isPasswordFocused = false
                                self.isUsernameFocused = true
                            }
                        
                    }
                    .padding(.top, 10)
                    .frame(height: 40)
                    .padding(.horizontal, horizontalPadding)
                    
                    Rectangle().fill(!isUsernameFocused && !isPasswordFocused ?  Color("gray-2") : Color.clear).frame(height: 1).frame(maxWidth: .infinity)
                        .padding(.horizontal, horizontalPadding)
                    
                    VStack(alignment: .leading){
                        if password != "" || isPasswordFocused {
                            Text("Passwort")
                                .font(.system(size: 13))
                                .foregroundColor(Color("gray-1"))
                                .padding(.horizontal, horizontalPadding)
                        }
                        SecureField(self.isPasswordFocused ? "" : "Passwort", text: self.$password)
                            //                    .font(Font.system(size: 17, weight: .medium))
                            .font(.system(size: 17))
                            .accentColor(Color ("black"))
                            .keyboardType(.alphabet)
                            .accentColor(Color ("primary_text"))
                            .padding(.horizontal, horizontalPadding)
                            .foregroundColor(Color ("black"))
                            .offset(y: (password != "" || isPasswordFocused) ? -9 : -2)
                            .onTapGesture {
                                self.isPasswordFocused = true
                                self.isUsernameFocused = false
                            }
                    }
                    .padding(.top, 10)
                    .frame(height: 40)
                    .padding(.horizontal, horizontalPadding)
                }
                .zIndex(0)
                
                if isUsernameFocused || isPasswordFocused {
                    VStack() {
                        RoundedRectangle(cornerRadius: 8).fill(Color (.clear)).frame(height: 56)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 3))
                            .padding(.horizontal, horizontalPadding)
                            .offset(y: isUsernameFocused ? -30 : 30)
                    }
                }
            }
            .padding(.bottom, 10)
            
            Group() {
                Button(action: signIn) {
                    HStack() {
                        Spacer()
                        Text("Einloggen")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(password != "" && username != "" ? Color.black : Color.white)
                        
                        Spacer()
                    }
                    .background(password != "" && username != "" ? Color("pink") : Color("gray"))
                    //                                        .background(password != "" && username != "" ? gradientBlueMint : gradientGray)
                    //                gradientPeachOrange
                }
                .disabled(!(password != "" && username != ""))
                .cornerRadius(8)
                .padding(.horizontal, horizontalPadding)
                //                .padding(.top, 10)
                
                Group() {
                    HStack() {
                        VStack() {
                            Divider()
                        }
                        Text("oder")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(Color("gray-1"))
                            .padding(.vertical)
                        
                        VStack() {
                            Divider()
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    
                    Button(action: unfocus) {
                        HStack() {
                            Image("apple")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 20)
                                //                            Divider()
                                .frame(height: 30)
                            Spacer()
                            Text("Mit Apple fortfahren")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(Color ("primary_text"))
                            
                            Spacer()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
                    //            .padding(.bottom, 8)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 10)
                    
                    
                    Button(action: abort) {
                        HStack() {
                            Image("facebook")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 20)
                                //                            Divider()
                                .frame(height: 30)
                            Spacer()
                            Text("Mit Facebook fortfahren")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(Color ("primary_text"))
                                .foregroundColor(.blue)
                            
                            Spacer()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
                    //            .padding(.bottom, 8)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 10)
                    
                    
                    Button(action: addSpacer) {
                        HStack() {
                            Image("google")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.leading, 20)
                                .foregroundColor(.red)
                            Spacer()
                            Text("Mit Google fortfahren")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(Color ("primary_text"))
                            
                            Spacer()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
                    .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius).stroke(Color .black, lineWidth: 1))
                    .padding(.bottom, 8)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 10)
                }
                //            .padding(.bottom, 50)
            }
            
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
            if addSpacerValue {
                Spacer()
                
            }
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
