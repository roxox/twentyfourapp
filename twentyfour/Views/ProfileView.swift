//
//  ProfileView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    
    func signOut() {
        appSettingsViewModel.isLoggedIn.toggle()
    }
    
    var body: some View {
        VStack() {
            Text("Mein Profil")
            
            Button(action: signOut) {
                HStack() {
                    Spacer()
                    Text("Abmelden")
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .background(Color.black)
            }
            .cornerRadius(8)
            .padding(.horizontal, horizontalPadding)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
