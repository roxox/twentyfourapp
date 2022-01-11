//
//  TabView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 12.04.21.
//

import SwiftUI

struct TabTestView: View {
    var body: some View {
        TabView {
//            UsersCollectionView()
//            HomeView()
//                .tabItem {
//                    Label("", systemImage: "magnifyingglass")
//                }
//            
//                UsersCollectionView()
//                    .tabItem {
//                        Label("", systemImage: "calendar")
//                    }
            
            ChatDetailsListView()
                .tabItem {
                    Label("", systemImage: "envelope")
                }
            
            ProfileView()
                .tabItem {
                    Label("", systemImage: "person.fill")
                        .listItemTint(.black)
                }
        }
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}
