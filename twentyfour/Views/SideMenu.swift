//
//  SideMenu.swift
//  twentyfour
//
//  Created by Sebastian Fox on 08.06.21.
//

import SwiftUI

struct SideMenu: View {
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    @Binding var showSideMenu: Bool
    
    func toggleSideMenu() {
        
            withAnimation(.linear(duration: 0.4)) {
                showSideMenu.toggle()
            }
    }
    
    
    func logOut() {
        
            withAnimation(.linear(duration: 0.4)) {
                appSettingsViewModel.isLoggedIn.toggle()
                toggleSideMenu()
            }
    }
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading) {
                
            
            Button(action: toggleSideMenu) {
                
                    Image(systemName: "xmark")
//                                .imageScale(.large)
                        .foregroundColor(.black)
                        .font(.system(size: 19, weight: .bold))
                        .padding(.horizontal, 9)
                        .padding(.vertical, 9)
            }
                
                Text("Profil ansehen")
                    .font(.system(size: 19))
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                    .padding(.leading, 10)
                Text("Nachrichten")
                    .font(.system(size: 19))
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                    .padding(.leading, 10)
                Text("Einstellungen")
                    .font(.system(size: 19))
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                    .padding(.leading, 10)
                
                Button(action: logOut) {
                    Text("Log Out")
                        .font(.system(size: 19))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                    }
                
                Spacer()
            }.padding(.top, 50)
            Spacer()
        }
        .background(Color.white)
    }
}

//struct SideMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenu()
//    }
//}
