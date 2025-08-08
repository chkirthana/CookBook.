import Foundation
import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var issecured : Bool = true
    @Published var showHome : Bool = false
}
