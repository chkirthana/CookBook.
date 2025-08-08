import Foundation
import SwiftUI
import Combine

class MyAccountViewModel: ObservableObject {
    @Published var showMenu = false
    @Published var navigateToWelcome = false
    @Published var isClicked = false
}
