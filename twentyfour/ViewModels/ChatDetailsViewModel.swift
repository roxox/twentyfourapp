//
//  ChatDetailsViewModel.swift
//  twentyfour
//
//  Created by Sebastian Fox on 16.03.21.
//

import Foundation
import FirebaseFirestore
import Firebase

class ChatDetailsViewModel: ObservableObject {

    @Published var chats = [ChatDetail]()
    
    func fetch() {
        print("Chat Detail Fetch")
    }
}
