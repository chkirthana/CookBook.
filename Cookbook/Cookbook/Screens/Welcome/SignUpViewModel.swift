import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var displayedUsername: String = "User"
    @Published var issecured : Bool = true
    @Published var showSignIn : Bool = false
}
