import SwiftUI
import Combine
import FirebaseStorage
import UIKit

let placeholder = UIImage(systemName: "person")!

struct FirebaseImage : View {

    init(id: String) {
        self.imageLoader = Loader(id)
    }

    @ObservedObject private var imageLoader : Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
//            .renderingMode(.original)
//            .resizable()
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
            .renderingMode(.original)
            .resizable()
    }
}
