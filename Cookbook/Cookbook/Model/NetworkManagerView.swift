import Foundation
import UIKit

final class NetworkManagerView {
    
    static let shared = NetworkManagerView()
    private init() {}

    private let imageCache = NSCache<NSString, UIImage>()

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://dummyjson.com/recipes") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Welcome.self, from: data)
        return decoded.recipes
    }

    func loadImage(from urlString: String) async -> UIImage? {
        if let cached = imageCache.object(forKey: urlString as NSString) {
            return cached
        }

        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
                return image
            }
        } catch {
            print("Image load error:", error)
        }

        return nil
    }
}
