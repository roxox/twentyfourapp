//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
    @Binding var viewIndex: Int
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var body: some View {
//        ZStack() {
        ZStack(alignment: .bottomLeading) {
            
            
            VStack(alignment: .leading) {
//                Divider()
                HStack() {
                    Spacer()
                    
                    Group(){
                    // Lupe
                    Button(action: {
                        self.viewIndex = 0
                    }) {
                        VStack() {
                            
//                            Image(systemName: viewIndex == 0 ? "magnifyingglass.fill" : "magnifyingglass")
                            Image(systemName: viewIndex == 0 ? "magnifyingglass" : "magnifyingglass")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 22, weight: viewIndex == 0 ? .bold : .medium))
                                .frame(width: 30, height: 35)
//                                .foregroundColor(viewIndex == 0 ? Color .black : .gray)
                                .foregroundColor(.black)
                                .offset(x: 0, y: 2)
                        }
                    }
                    
                    Spacer()
                    Button(action: {
                        self.viewIndex = 1
                    }) {
                        VStack() {
                            
                            Image(systemName: viewIndex == 1 ? "calendar" : "calendar")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 22, weight: viewIndex == 1 ? .bold : .medium))
                                .frame(width: 30, height: 35)
//                                .foregroundColor(viewIndex == 1 ? Color .black : .gray)
                                .foregroundColor(.black)
                                .offset(x: 0, y: 2)
                        }
                    }
                    
                    Spacer()
                    
                    //                  Button Message
                    Button(action: {
                        self.viewIndex = 2
                    }) {
                        VStack() {
                            Image(systemName: viewIndex == 2 ? "bubble.left.and.bubble.right" : "bubble.left.and.bubble.right")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 22, weight: viewIndex == 2 ? .bold : .medium))
                                .frame(width: 30, height: 35)
//                                .foregroundColor(viewIndex == 2 ? Color .black : .gray)
                                .foregroundColor(.black)
                                .offset(x: 0, y: 2)
                        }
                    }
                    
                    Spacer()
                    
                    //                  Button Profil
                    Button(action: {
                        self.viewIndex = 3
                    }) {
                        VStack() {
                            Image(systemName: viewIndex == 3 ? "person" : "person")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 22, weight: viewIndex == 3 ? .bold : .medium))
                                .frame(width: 30, height: 35)
//                                .foregroundColor(viewIndex == 3 ? Color .black : .gray)
                                .foregroundColor(.black)
                                .offset(x: 0, y: 2)
                        }
                    }
                    }
                    Spacer()
                }
                .padding(.top, 10)
            }
            .background((Color .white)
            .edgesIgnoringSafeArea(.all))
        }
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
