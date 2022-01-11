//
//  Post.swift
//  Post
//
//  Created by Balaji on 24/08/21.
//

import SwiftUI

struct Post: Identifiable,Hashable {
    var id = UUID().uuidString
    var imageURL: String
}

// since we declared T as Identifiable...
// so we need to pass Idenfiable conform collection/Array...

struct PostCardView: View{
    
    var post: Post
    @State private var altMode: Bool = true
    @State private var active: Bool = false
    
    let cornerRadius = CGFloat(10)
    
    var body: some View{
        
        
        Button(action: {
            withAnimation(.linear(duration: 0.2)) {
                self.active.toggle()
            }
        }) {
            
            VStack(alignment: .leading){
                ZStack(alignment: .leading) {
                    Color.black.opacity(0.1)
                        .cornerRadius(cornerRadius)
                    
                    Image(post.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //                        .blur(radius: active ? 0 : 1.5)
                        .cornerRadius(cornerRadius)
                        .opacity(active ? 0 : 1)
                    //                        .shadow(radius: 1, y: 0.7)
                    
                    
                    if active {
//                        Color.black.opacity(1)
//                        Color.white.opacity(1)
                        Color("textbox").opacity(1)
                            .cornerRadius(cornerRadius)
                            .offset(y: -1.5)
                        //                        BlurView(style: .regular)
                        //                        .cornerRadius(cornerRadius)
                    } else {
                        //                        Color("background").opacity(0.2)
                        Color.black.opacity(0.1)
                            .cornerRadius(cornerRadius)
                    }
                    
                    //                    if post.imageURL == "post1" {
                    
                    VStack(alignment: .leading){
                        Spacer()
                        //                            Spacer()
                        
                        //                            HStack() {
                        //                                Text("Essen & Trinken")
                        //                                    .font(.cerealBold(size: 8))
                        //                                //.font(.system(size: 20))
                        //                                    .fontWeight(.black)
                        //                                //                    .underline()
                        //                                //                               .foregroundColor(Color("mint"))
                        //                                    .foregroundColor(Color.white)
                        //                                    .padding(3)
                        //                                    .padding(.horizontal, 3)
                        //                                    .background(Color.black.opacity(0.4))
                        //                                    .lineLimit(2)
                        //                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                        //                                Spacer()
                        //                            }
                        
                        if active {
                            
                            HStack() {
                                Text(post.imageURL == "post1" ? "Mira" : "Basti")
                                    .font(.cerealBold(size: active ? 26 : 16))
//                                    .fontWeight(active ? .black : .medium)
                                    .foregroundColor(Color("foreground"))
//                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding(.bottom, active ? 0 : 10)
                            
                            HStack(){
                                Text("Essen & Trinken")
                                //.font(.system(size: 20))
                                    .font(.cereal(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("foreground"))
//                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            HStack(){
                                Text("Nachtleben")
                                //.font(.system(size: 20))
                                    .font(.cereal(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("foreground"))
//                                    .foregroundColor(.white)
                                    .lineLimit(5)
                                Spacer()
                            }
                            
                            HStack(){
                                Text("Sport")
                                //.font(.system(size: 20))
                                    .font(.cereal(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("foreground"))
//                                    .foregroundColor(.white)
                                    .lineLimit(5)
                                Spacer()
                            }
                            HStack(){
                                Text("Freizeit")
                                //.font(.system(size: 20))
                                    .font(.cereal(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("foreground"))
//                                    .foregroundColor(.white)
                                    .lineLimit(5)
                                Spacer()
                            }
                            
                            
//                            HStack(alignment: .lastTextBaseline){
//                                Text("Ich habe voll Bock auf einen Burger bei Gordon Ramsey und danach viellciht Siedler")
//                                //.font(.system(size: 20))
//                                    .font(.cereal(size: 13))
//                                //                                        .fontWeight(.bold)
//                                    .foregroundColor(Color("foreground"))
////                                                                        .foregroundColor(.white)
//                                    .lineLimit(3)
//                                //                                    Spacer()
//                            }
//                            .offset(y: 5)
                            
                            HStack(alignment: .top){
                              //  Spacer()
                                //                                    Image(systemName: "person.fill")
                                //                                        .font(.system(size: 23, weight: .bold))
                                //                                        .frame(width: 35, height: 35)
                                //                                        .foregroundColor(Color("foreground"))
                                VStack(){
                                Image(post.imageURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    
//                                    HStack(){
//                                Text("Profil\nansehen")
//                                //.font(.system(size: 20))
//                                    .font(.cerealBook(size: 10))
//                                   // .fontWeight(.bold)
//                                    .lineLimit(2)
//                                    .foregroundColor(Color("foreground"))
////                                    .foregroundColor(.white)
//                                    }
                                }
                                
                                Spacer()
                                
                                ZStack(){
                                    
                                    Image(systemName: "bubble.left.fill")
                                        .font(.system(size: 20, weight: .bold))
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(Color("gradient1"))
                                    
                                    Image(systemName: "bubble.left")
                                        .font(.system(size: 20, weight: .bold))
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(Color("foreground"))
//                                        .clipShape(Circle())
                                    
//                                    Text("Nachricht\nschreiben")
//                                    //.font(.system(size: 20))
//                                        .font(.cerealBook(size: 10))
//                                       // .fontWeight(.bold)
//                                        .lineLimit(2)
//                                        .foregroundColor(Color("foreground"))
////                                        .foregroundColor(.white)
                                }
                                .background(Color("gray-7").opacity(0.5))
                                .clipShape(Circle())
                                
                                Spacer()
                                
                                ZStack(){
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(Color("gradient4"))
                                    
                                    Image(systemName: "person.2")
                                        .font(.system(size: 20, weight: .bold))
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(Color("foreground"))
                                    
                                
//                                Text("Gruppe\nerstellen")
//                                //.font(.system(size: 20))
//                                        .font(.cerealBook(size: 10))
//                                       // .fontWeight(.bold)
//                                    .lineLimit(2)
//                                    .foregroundColor(Color("foreground"))
////                                    .foregroundColor(.white)
                            }
                                .background(Color("gray-7").opacity(0.5))
                                .clipShape(Circle())
                                
                             //   Spacer()
                            }
                            .offset(y: 5)
                            .padding(.bottom, horizontalPadding)
                        }
                        if active {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    //                    .font(.cerealBold(size: 23))
                    .foregroundColor(.white)
                    
                }
                //                .opacity(active ? 1 : 3)
                
            }
            //                    .padding(.bottom, !altMode ? 20 : 5)
            //                    .padding(.horizontal, 5)
        }
    }
}
