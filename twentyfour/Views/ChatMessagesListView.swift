//
//  ChatMessagesListView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatMessagesListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var textMessage: String = ""
    let user: User
    let itemWidth: CGFloat = (screenWidth-30)/7
    let itemHeight: CGFloat = (screenWidth-30)/7
    
    var body: some View {
        
        VStack() {
//            HStack() {
//
//                WebImage(url: URL(string: user.imageLink))
//                    .placeholder(Image(systemName: "photo")) // Placeholder Image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: itemWidth, height: itemWidth)
//                    .clipShape(Circle())
//                Spacer()
//
//                Text(user.name)
//                    .font(.system(size: 16))
//                    .fontWeight(.bold)
//                    .foregroundColor(Color ("primary_text"))
//                    .lineLimit(1)
//                Spacer()
//            }
//            .padding(.vertical)
//            .padding(.horizontal, horizontalPadding)
//            .background(Color("gray-3"))
            
            ScrollView() {
                Text("Chat Messages")
                    .padding()
                Rectangle().fill(Color .clear).frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
//            Spacer()
            HStack() {
            ZStack(){
                
                RoundedRectangle(cornerRadius: 10).fill(Color ("gray-3")).frame(height: 37)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("gray-2"), lineWidth: 1))
                
            
                TextField("Deine Nachricht", text: self.$textMessage)
                    .font(.system(size: 17))
                    .accentColor(Color ("black"))
                    .keyboardType(.alphabet)
                    .accentColor(Color ("primary_text"))
                    .background(Color.clear)
                    
                    
                    .padding(.horizontal, horizontalPadding)
                    .foregroundColor(Color ("black"))
                
            }
//            .padding(.vertical)
            .frame(height: 25)
            .padding(.bottom, 10)
             
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding()
                    .foregroundColor(Color("blue-1"))
                
            }
            .padding(.horizontal, horizontalPadding)
        }
        .navigationTitle("")
//                .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                HStack() {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(Font.system(size: 20, weight: .semibold))
                                        //                            Text("zurück")
                                        //                                .foregroundColor(.black)
                                        .foregroundColor(Color ("primary_text"))
//                                        .padding()
//                                        .offset(x: -15)
                                }
                                .padding(.trailing)
                                    
                                    WebImage(url: URL(string: user.imageLink))
                                        .placeholder(Image(systemName: "photo")) // Placeholder Image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                    
                                    Text(user.name)
                                })
    }
}

//struct ChatMessagesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatMessagesListView()
//    }
//}


    
    
