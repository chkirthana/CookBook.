import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var selectedCuisine: String? = nil
    @Published var currentindex: Int = 0
    @Published var favoriteRecipes: [Recipe] = []
    @Published var uniqueCuisines: [String] = []
}
