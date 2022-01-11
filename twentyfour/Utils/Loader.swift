import SwiftUI
import Combine
import FirebaseStorage

final class Loader : ObservableObject {
    @Published var data : Data?

    init(_ id: String){
        // the path to the image
        let url = "profilepics/\(id)"
        print("load image with id: \(id)")
        print("Image URL: \(url)")
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
