//
//  HomeView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI
import UIKit
import MapKit
import Firebase
import SDWebImageSwiftUI
import CoreLocation
import Lottie

struct HomeView: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    @EnvironmentObject var usersViewModel: UsersViewModel
    
    // Picker Options
    var settings = ["Alle", "Chats", "Gruppen"]
    
    @State private var pageId: String = "home"
    @State private var searchActive: Bool = false
    @State private var searchFood: Bool = false
    @State private var searchFun: Bool = false
    @State private var searchSport: Bool = false
    @State private var showFood: Bool = true
    @State private var showFun: Bool = true
    @State private var showSport: Bool = true
    @State private var showNightlife: Bool = true
    @State private var showResults: Bool = true
    @State private var selectedUser: User = User(name: "", imageLink: "", lang: 0, long: 0, id: "", isFoodSelected: false)
    @State private var selectedUsers: [User] = []
    @State private var showOverlay: Bool = false
    @State var mapChoioce = 0
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.729680, longitude: 9.781770), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    func clearSelectedUsers() {
        self.selectedUsers.removeAll()
    }
    
    func setPageId(_ pageId: String) {
        self.pageId = pageId
    }
    
    func signOut() {
        appSettingsViewModel.isLoggedIn.toggle()
    }
    
    func getHeaderLabel() -> String {
        
        switch pageId {
        case "home": return ""
        case "chat": return "Chats"
        case "profile": return "Profil"
        default:
            return ""
        }
    }
    
    func checkForChange() -> Bool {
        var change = false
        if showFood != searchFood {
            change = true
        }
        if showFun != searchFun {
            change = true
        }
        if showSport != searchSport {
            change = true
        }
        return change
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView() {
                ZStack(alignment: .center) {
                    VStack(alignment: .center) {
                        VStack(alignment: .center){
                            
                            Rectangle().fill(Color.clear).frame(height: 40)
                            ZStack(){
                                HStack(){
                                    
                                    if pageId == "home" {
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.2)) {
                                                //                                            self.setPageId("home")
                                                self.showOverlay.toggle()
                                            }
                                        }) {
                                            ZStack() {
                                                
                                                Image(systemName: "circle.fill")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .frame(height: 52)
                                                    .foregroundColor(Color("background").opacity(0.82))
                                                    .offset(x: -3, y: -3)
                                                
                                                Image(systemName: "sparkle.magnifyingglass")
                                                    .font(.system(size: 24, weight: .bold))
                                                    .frame(height: 52)
                                                    .foregroundColor(.yellow)
                                                
                                                Image(systemName: "magnifyingglass")
                                                    .font(.system(size: 24, weight: .bold))
                                                    .frame(height: 52)
                                                    .foregroundColor(Color("foreground"))
                                            }
                                        }
                                    } else {
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.3)) {
                                                self.setPageId("home")
                                            }
                                        }) {
                                            Image(systemName: "chevron.left")
                                                .font(.system(size: 20, weight: .semibold))
                                                .frame(height: 52)
                                                .foregroundColor(Color("foreground"))
                                            
                                        }
                                    }
                                    Spacer()
                                    
                                    if pageId == "home" {
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.3)) {
                                                self.setPageId("chat")
                                            }
                                        }) {
                                            ZStack() {
                                                Image(systemName: "bubble.left.and.bubble.right.fill")
                                                    .font(.system(size: 22, weight: .bold))
                                                    .frame(height: 52)
                                                    .foregroundColor(Color("background").opacity(0.82))
                                                    .padding(.trailing, 10)
                                                
                                                
                                                Image(systemName: "bubble.left.and.bubble.right")
                                                    .font(.system(size: 22, weight: .bold))
                                                    .frame(height: 52)
                                                    .foregroundColor(Color("foreground"))
                                                    .padding(.trailing, 10)
                                            }
                                        }
                                        
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.3)) {
                                                self.setPageId("profile")
                                            }
                                        }) {
                                            Image("post1")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 36, height: 36)
                                                .clipShape(Circle())
                                        }
                                        .foregroundColor(Color("foreground"))
                                    }
                                    
                                }
                                HStack() {
                                    Spacer()
                                    Text(self.getHeaderLabel())
                                        .font(.cereal(size: 15))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("foreground"))
                                    Spacer()
                                }
                                .id(UUID())
                            }
                            .padding(.horizontal, horizontalPadding)
                            
                            // Hier geht es richtig los
                            if showResults {
                                ZStack() {
                                    //                                    if pageId == "home" {
                                    ScrollView(showsIndicators: false) {
                                        if usersViewModel.users.count > 3 {
                                            VStack(){
                                                GroupingsCollectionView()
                                                
                                                Rectangle().fill(Color.clear).frame(height: 60)
                                                
                                            }
                                        }
                                    }
                                    .edgesIgnoringSafeArea(.bottom)
                                    .opacity(pageId == "home" ? 1 : 0)
                                    .offset(x: pageId == "home" ? 0 : -screenWidth)
                                    //                                    }
                                    
                                    //                                    if pageId == "chat" {
                                    VStack(){
                                        VStack(){
                                            Spacer()
                                            HStack() {
                                                Spacer()
                                                Text("Noch sind keine Chats vorhanden")
                                                    .font(.cereal(size: 15))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color("foreground"))
                                                Spacer()
                                            }
                                            Spacer()
                                        }.background(Color("background"))
                                        VStack() {
                                            HStack(){
                                                Spacer()
                                                Picker("Options", selection: $mapChoioce) {
                                                    ForEach(0 ..< settings.count) { index in
                                                        Text(self.settings[index])
                                                            .tag(index)
                                                    }
                                                    
                                                }.pickerStyle(SegmentedPickerStyle())
                                                    .frame(width: screenWidth/2)
                                                    .padding()
                                                
                                                Spacer()
                                            }
                                            
                                            Rectangle().fill(Color.clear).frame(height: 20)
                                        }
                                    }
                                    .opacity(pageId == "chat" ? 1 : 0)
                                    .offset(x: pageId == "chat" ? 0 : screenWidth)
                                    VStack(){
                                        Spacer()
                                        Text("Noch nicht eingebaut")
                                            .font(.cereal(size: 21))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("foreground"))
                                        Spacer()
                                        Rectangle().fill(Color.clear).frame(height: 60)
                                    }
                                    .opacity(pageId == "profile" ? 1 : 0)
                                    .offset(x: pageId == "profile" ? 0 : screenWidth)
                                }
                            }
                            
                        }
                        Spacer()
                    }
                    .background(Color("sand"))
                    .edgesIgnoringSafeArea(.all)
                    
                    if showOverlay {
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.showOverlay.toggle()
                            }
                        }) {
                            Color.black.opacity(showOverlay ? 0.2 : 0)
                                .edgesIgnoringSafeArea(.all).animation(.spring())
                        }
                    }
                }
                .navigationBarHidden(true)
                .navigationBarTitle("Users", displayMode: .large)
                .navigationBarBackButtonHidden(false)
                .navigationBarBackButtonHidden(false)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
