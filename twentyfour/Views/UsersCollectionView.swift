//
//  UserCollectionView.swift
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

struct UsersCollectionView: View {
    @EnvironmentObject var usersViewModel: UsersViewModel
    @Binding var showFilter: Bool
    @Binding var showMap: Bool
    @Binding var user: User
    @Binding var showSelectedUserMenu: Bool
    @Binding var selectedUsers: [User]
    
    let itemWidth: CGFloat = (screenWidth-30)/4.8
    let itemHeight: CGFloat = (screenWidth-30)/4.8
    var fixedLayout: [GridItem] {
        [
            .init(.fixed((screenWidth-30)/3.2)),
            .init(.fixed((screenWidth-30)/3.2)),
            .init(.fixed((screenWidth-30)/3.2))
        ]
    }
    
    func setUser(user: User){
        self.user = user
    }
    
    var body: some View {
        
        LazyVGrid(columns: fixedLayout, spacing: 30) {
            ForEach(usersViewModel.users, id: \.self) { user in
                if user.isFoodSelected == true {
                    
                    Button(action: {
                        
                        withAnimation(.linear(duration: 0.3)) {
                            setUser(user: user)
                            showSelectedUserMenu.toggle()
                        }
                        
                    }) {
                        VStack(){
                            WebImage(url: URL(string: user.imageLink))
                                .placeholder(Image(systemName: "photo")) // Placeholder Image
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth, height: itemHeight)
                            //.cornerRadius(36)
                            .clipShape(Circle())
                                .foregroundColor(.black)
                                .contextMenu {
                                    Text(user.name)
                                    Button {
                                        print("Profil anzeigen")
                                    } label: {
                                        Label("Profil anzeigen", systemImage: "person")
                                    }
                                    
                                    Button {
                                        print("Gruppe erstellen")
                                    } label: {
                                        Label("Gruppe erstellen", systemImage: "person.3")
                                    }
                                }.background(Color.white)
                            
                            Text(user.name)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        
                        
                    }
                }
            }
        }
        .padding(.vertical, 25)
        .background(Color.white)
    }
}


struct UsersPreviewView: View {
    @EnvironmentObject var usersViewModel: UsersViewModel
    @Binding var showFilter: Bool
    @Binding var showMap: Bool
    @Binding var user: User
    @Binding var showSelectedUserMenu: Bool
    @Binding var selectedUsers: [User]
    
    
    func addOrRemoveUserFromSelected(user: User) {
        if !selectedUsers.contains(user) {
            selectedUsers.append(user)
        } else {
            let userIndex = selectedUsers.firstIndex(of: user)
            selectedUsers.remove(at: userIndex!)
        }
    }
    
    let itemWidth: CGFloat = (screenWidth-30)/4.8
    let itemHeight: CGFloat = (screenWidth-30)/4.8
    var fixedLayout: [GridItem] {
        [
            .init(.fixed((screenWidth-30)/3.2)),
            .init(.fixed((screenWidth-30)/3.2)),
            .init(.fixed((screenWidth-30)/3.2))
        ]
    }
    
    func setUser(user: User){
        self.user = user
    }
    
    var body: some View {
        VStack() {
            
        ScrollView(.horizontal, showsIndicators: false){
            HStack(){
                ForEach(usersViewModel.users, id: \.self) { user in
                    if user.isFoodSelected == true {
                            VStack(){
                                ZStack(){
                                WebImage(url: URL(string: user.imageLink))
                                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: itemWidth, height: itemHeight)
                                    //.cornerRadius(36)
                                    .clipShape(Circle())
                                    .foregroundColor(.black)
                                    .contextMenu {
                                        Text(user.name)
                                        Button {
                                            print("Profil anzeigen")
                                        } label: {
                                            Label("Profil anzeigen", systemImage: "person")
                                        }
                                        
                                        Button {
                                            print("Gruppe erstellen")
                                        } label: {
                                            Label("Gruppe erstellen", systemImage: "person.3")
                                        }
                                    }.background(Color.white)
                                    
                                    
                                    Button(action: {
                                        withAnimation(.linear(duration: 0.2)) {
                                            self.addOrRemoveUserFromSelected(user: user)
                                        }
                                        
                                    }) {
                                    ZStack() {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 26, weight: .bold))
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.white)
//
                                        Image(systemName: selectedUsers.contains(user) ? "circle.fill" : "circle")
                                            .font(.system(size: 22, weight: .bold))
                                            .frame(width: 35, height: 35)
//                                            .foregroundColor(Color("violet"))
                                            .foreground(testgradientBlueblue2)
                                        
                                        if selectedUsers.contains(user) {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 15, weight: .bold))
                                                .frame(width: 35, height: 35)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    }
                                    .offset(x: 30, y: -30)
                                }
                                Text(user.name)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.black)
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading, 19)
                    }
                }
            }
        }
        }
        .padding(.vertical, 15)
        .background(Color.white)
    }
}
