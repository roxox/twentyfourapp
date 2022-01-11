//
//  UserDetailView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.03.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    var user: User?
    //    @Binding var user: User
    let itemWidth: CGFloat = (screenWidth-30)/3
    //    let itemHeight: CGFloat = (screenWidth-30)/3
    
    private let imageHeight: CGFloat = screenWidth+150
    private let collapsedImageHeight: CGFloat = 0
    
    @State private var isMessagePresented = false
    
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
    
    //    let itemWidth: CGFloat = (screenWidth-30)/6
    //    let itemHeight: CGFloat = (screenWidth-30)/6
    
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.frame(in: .global).minY
    }
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        
        // if our offset is roughly less than -225 (the amount scrolled / amount off screen)
        if offset < -sizeOffScreen {
            // Since we want 75 px fixed on the screen we get our offset of -225 or anything less than. Take the abs value of
            let imageOffset = abs(min(-sizeOffScreen, offset))
            
            // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
            
            return imageOffset - sizeOffScreen
        }
        
        // Image was pulled down
        if offset > 0 {
            return -offset
            
        }
        
        return 0
    }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height
        
        if offset > 0 {
            return imageHeight + offset
        }
        
        return imageHeight + offset
    }
    
    // at 0 offset our blur will be 0
    // at 300 offset our blur will be 6
    func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        
        return blur * 6 // Values will range from 0 - 6
    }
    
    
    func getOverlayOpacity(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let opacity = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        
        return opacity // Values will range from 0 - 6
    }
    
    func getShadowOpacity(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let opacity = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        
        return opacity // Values will range from 0 - 6
    }
    
    // 1
    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY
        
        // (x - min) / (max - min) -> Normalize our values between 0 and 1
        
        // If our Title has surpassed the bottom of our image at the top
        // Current Y POS will start at 75 in the beggining. We essentially only want to offset our 'Title' about 30px.
        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 50.0 // What we consider our min for our scroll offset
            let maxYValue: CGFloat = collapsedImageHeight // What we start at for our scroll offset (75)
            let currentYValue = currentYPos
            
            let percentage = max(-1, (currentYValue - maxYValue) / (maxYValue - minYValue)) // Normalize our values from 75 - 50 to be between 0 to -1, If scrolled past that, just default to -1
            let finalOffset: CGFloat = -30.0 // We want our final offset to be -30 from the bottom of the image header view
            
            // We will start at 20 pixels from the bottom (under our sticky header)
            // At the beginning, our percentage will be 0, with this resulting in 20 - (x * -30)
            // as x increases, our offset will go from 20 to 0 to -30, thus translating our title from 20px to -30px.
            
            return 20 - (percentage * finalOffset)
        }
        
        return .infinity
    }
    
    
    
    var body: some View {
        ZStack() {
            ScrollView {
                VStack {
                    VStack(alignment: .center) {
                        Group() {
                            HStack() {
                                Text(user!.name)
                                    .font(.system(size: 26))
                                    .fontWeight(.bold)
//                                    .font(.systemMedium(size: 26))
                                    .foregroundColor(Color.black)
                                    .lineLimit(1)
//                                    .background(GeometryGetter(rect: self.$titleRect)) // 2
//                                Spacer()
                            }
                            .background(GeometryGetter(rect: self.$titleRect)) // 2
//                            .padding(.top, 10)
                            
                            
                            Text("\(user!.name) hat noch nichts über sich geschrieben")
//                                .font(Font.system(size: 16, weight: .medium))
                                .font(Font.system(size: 16))
                                .foregroundColor(Color("gray-2"))
                                .italic()
                                .padding(.top, 10)
                            
                            
                            Text("Hamburg")
//                                .font(Font.system(size: 16, weight: .semibold))
                                .font(Font.system(size: 16))
                                .foregroundColor(Color("gray-2"))
                                .italic()
                                .padding(.bottom, 10)
                            
//                            Divider().padding(.vertical)
//
//                            Text("Über mich:")
//                                .font(Font.system(size: 16, weight: .semibold))
//
//                            Text("Caro hat noch nichts über sich geschrieben")
//                                .font(Font.system(size: 16))
                            
//                            Divider()
//                                .padding(.vertical)
                            
//                            HStack() {
                            NavigationLink(destination: ChatMessagesListView(user: user!)) {
    
                                HStack() {
                                    
                                        Image(systemName: "envelope")
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color ("black"))
                                            .frame(width: 30)
                                    
                                    Text("Nachricht schicken")
                                        .font(.system(size: 18))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color ("primary_text"))
                                        .lineLimit(1)
                                }
    
                            }
                            .padding(.vertical, 5)
                            
                            HStack() {
                                
                                    Image(systemName: "person.2")
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color ("black"))
                                        .frame(width: 30)
                                
                                Text("Gruppe erstellen")
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color ("primary_text"))
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 5)
//                            }
                            
//                            Divider()
//                                .padding(.vertical)
                            
                            HStack() {
                                
                                    Image(systemName: "xmark")
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color ("black"))
                                        .frame(width: 30)
                                
                                Text("User melden")
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color ("primary_text"))
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 5)
                            .padding(.bottom, 60)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 16.0)
                }
                .offset(y: imageHeight + 16)
//                .shadow(radius: 3)
                .background(GeometryGetter(rect: $articleContent.frame))
                
                GeometryReader { geometry in
                    // 3
                    ZStack(alignment: .bottom) {
                        
                        ZStack() {
                        WebImage(url: URL(string: user!.imageLink))
                            .placeholder(Image(systemName: "photo")) // Placeholder Image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
//                            .blur(radius: self.getBlurRadiusForImage(geometry))
//                            .overlay(Color.white.opacity(Double(self.getOverlayOpacity(geometry))))
                            .overlay(gradient)
                            .clipped()
                            .background(GeometryGetter(rect: self.$headerImageRect))
                        }
                        
                        // 4
                        VStack() {
                            HStack() {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .padding()
                                        .imageScale(.large)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                            .padding(.top, 30)
                            
                            Spacer()
                        }
                        .offset(x: 0, y: self.getHeaderTitleOffset())
                        //
                        //                        Spacer()
                        
                        //                    Text("How to build a parallax scroll view")
                        //                        .font(.avenirNext(size: 17))
                        //                        .foregroundColor(.white)
                        //                        .offset(x: 0, y: self.getHeaderTitleOffset())
                        
                        
                        HStack() {
                            Text(user!.name)
                                //                        .font(.avenirNext(size: 17))
//                                .font(.systemMedium(size: 17))
                                .foregroundColor(.white)
                            
                        }
                        .offset(x: 0, y: self.getHeaderTitleOffset())
                    }
                    .clipped()
                    .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
                    .shadow(radius: 1)
                }.frame(height: imageHeight)
                .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
            }
            
            VStack() {
                HStack() {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "chevron.left")
                                    .padding()
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                            )
                            
                            .padding(.horizontal, 15)
                            .padding(.top, 38)
                    }
                    Spacer()
                }
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
        
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
        
        
        
        
        
//        ZStack() {
//            //        GeometryReader { geometry in
//            ScrollView() {
//                VStack() {
//
//                    HStack() {
//                        Text(user!.name)
//                            //                            .font(.system(size: 26))
//                            .foregroundColor(Color.black)
//                            .lineLimit(1)
//                        //                                    .background(GeometryGetter(rect: self.$titleRect)) // 2
//                        Spacer()
//                    }
//                    .background(GeometryGetter(rect: self.$titleRect)) // 2
//                    .padding(.top, 10)
//
//
//
//                    HStack() {
//                        Spacer()
//                        WebImage(url: URL(string: user!.imageLink))
//                            .placeholder(Image(systemName: "photo")) // Placeholder Image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: itemWidth, height: itemWidth)
//                            .clipShape(Circle())
//                        Spacer()
//                        //                    .padding(.bottom)
//                    }
//                    Text(user!.name)
//                        .font(.system(size: 24))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color ("primary_text"))
//                        .lineLimit(1)
//
//                    HStack() {
//
//
//                        Button(action: {
//                            isMessagePresented.toggle()
//                        })  {
//                            VStack(alignment: .center) {
//                                Circle().fill(Color("gray")).frame(width: 40, height: 40)
//                                    .overlay(
//                                        Image(systemName: "envelope.fill")
//                                            .foregroundColor(Color ("black"))
//                                    )
//                                Text("Nachricht")
//                                    .font(.system(size: 11))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color ("primary_text"))
//                                    .lineLimit(1)
//                            }
//                        }
//                        .sheet(isPresented: $isMessagePresented) {
//                            ChatMessagesListView(user: user!)
//                        }
//
//
//
//                        //                    Button(isMessagePresented.toggle) {
//                        //
//                        //                        VStack(alignment: .center) {
//                        //                            Circle().fill(Color("gray")).frame(width: 40, height: 40)
//                        //                                .overlay(
//                        //                                    Image(systemName: "envelope.fill")
//                        //                                        .foregroundColor(Color ("black"))
//                        //                                )
//                        //                            Text("Nachricht")
//                        //                                .font(.system(size: 11))
//                        //                                .fontWeight(.bold)
//                        //                                .foregroundColor(Color ("primary_text"))
//                        //                                .lineLimit(1)
//                        //                        }
//                        //
//                        //                    }
//                        //                    .sheet(isPresented: $isMessagePresented) {
//                        //                        SignInView()
//                        //                    }
//
//                        NavigationLink(destination: ChatMessagesListView(user: user!)) {
//
//                            VStack(alignment: .center) {
//                                Circle().fill(Color("gray")).frame(width: 40, height: 40)
//                                    .overlay(
//                                        Image(systemName: "person.2.fill")
//                                            .foregroundColor(Color ("black"))
//                                    )
//                                Text("Neue Gruppe")
//                                    .font(.system(size: 11))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color ("primary_text"))
//                                    .lineLimit(1)
//                            }
//
//                        }
//                    }
//
//
//
//                    Spacer()
//                }
//            }
//            //        }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//            //        .navigationBarItems(leading:
//            //                                HStack() {
//            //                                Button(action: {
//            //                                    self.presentationMode.wrappedValue.dismiss()
//            //                                }) {
//            //                                    Image(systemName: "xmark")
//            //                                        .font(Font.system(size: 20, weight: .bold))
//            //                                        //                            Text("zurück")
//            //                                        //                                .foregroundColor(.black)
//            //                                        .foregroundColor(Color ("primary_text"))
//            //                                        .padding()
//            //                                        .offset(x: -15)
//            //                                }
//            //                                })
//        }
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailView()
//    }
//}
