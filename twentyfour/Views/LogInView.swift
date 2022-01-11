//
//  LogInView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    //    Variables
    @State var showSignUp = false
    @State var showSignIn = false
    
    
    @State private var isLogInPresented = false
    
    func showSignInView() {
        appSettingsViewModel.showLogin = true
    }
    
    func showSignUpView() {
        appSettingsViewModel.showRegister = true
    }
    
    var body: some View {
//        NavigationView() {
        ZStack() {
            //            Color.red
            
            HStack() {
                Spacer()
                VStack() {
                    Spacer()
                    
//                    Text("twentyfour")
//                        .font(.system(size: 38))
//                        .fontWeight(.bold)
////                        .foregroundColor(.black)
//                        .foregroundColor(Color("pink"))
//                    
//                    Text("enjoy moments together")
//                        .font(.system(size: 24))
//                        .fontWeight(.bold)
////                        .foregroundColor(.black)
//                        .foregroundColor(Color("pink"))
                    
                    Spacer()
                    
                    
//                    Button("Present!") {
//                        isLogInPresented.toggle()
//                    }
//                    .sheet(isPresented: $isLogInPresented) {
//                        SignInView()
//                    }
                    
//                    NavigationLink(destination: SignInView()) {
//                        Text("NavView")
//                            .font(.system(size: 19))
//                            .fontWeight(.semibold)
//                            //                                        .foregroundColor(.black)
//                            .foregroundColor(Color ("primary_text"))
//                    }
//                    .padding()
                    
                    Button(action: showSignInView) {
                        withAnimation(.linear(duration: 0.4)) {
                            
                            HStack() {
                                Spacer()
                                Text("Anmelden")
                                    .font(.system(size: 19))
                                    .fontWeight(.medium)
                                    .padding()
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .background(Color.black.opacity(0.15))
                            
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color .white, lineWidth: 2))
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    
                    Button(action: showSignUpView) {
                        withAnimation(.linear(duration: 0.4)) {
                            
                            HStack() {
                                Spacer()
                                Text("Registrieren")
                                    .font(.system(size: 19))
                                    .fontWeight(.medium)
                                    .padding()
//                                    .foregroundColor(.black)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .background(Color.black)
                            
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color .clear, lineWidth: 1))
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                }.padding(.bottom, 50)
                Spacer()
            }
        }
//        }.background(Color.clear)
        //        .background(Color.black)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
