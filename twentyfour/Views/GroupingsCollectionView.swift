//
//  GroupingCollectionView.swift
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

struct GroupingsCollectionView: View {
    @EnvironmentObject var usersViewModel: UsersViewModel
    
    @State var posts: [Post] = []
    
    // To show dynamic...
    @State var columns: Int = 2
    
    // Smooth Hero Effect...
    @Namespace var animation
    
    let itemWidth: CGFloat = (screenWidth-30)
    let itemHeight: CGFloat = (screenWidth-30)/4.5
    
    let photoWidth: CGFloat = (screenWidth-30) / 6.8
    
    var body: some View {
        
        VStack() {
            StaggeredGrid(columns: columns, list: posts, content: { post in
                
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
            })
            .padding(.horizontal)
        }
        .onAppear {
            for index in 1...8{
                posts.append(Post(imageURL: "post\(index)"))
            }
        }
    }
}
