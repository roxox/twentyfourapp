//
//  ChatListView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI

struct ChatDetailsListView: View {
    
    @ObservedObject var chatDetailsViewModel = ChatDetailsViewModel()
    
    var body: some View {
        NavigationView(){
            Text("Nachrichten")
        }
        .navigationTitle("")
        
//        .navigationBarHidden(true)
//        .onAppear(){
//            chatDetailsViewModel.fetch()
//        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailsListView()
    }
}
