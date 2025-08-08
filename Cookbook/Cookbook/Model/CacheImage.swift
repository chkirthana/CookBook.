import SwiftUI

struct CacheImage: View {
    let url: String
    let width: CGFloat
    let height: CGFloat

    @State private var uiImage: UIImage?

    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: width, height: height)
                    .task {
                        uiImage = await NetworkManagerView.shared.loadImage(from: url)
                    }
            }
        }
    }
}

