import SwiftUI
import Combine

@main
struct CookbookApp: App {
    @State var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
                    .environmentObject(settingsapp())
            }
            else {
                WelcomeView()
                    .environmentObject(settingsapp())
            }
        }
    }
}



class settingsapp : ObservableObject {
    @AppStorage("username") var username: String = ""
    @AppStorage("password") var password: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
}
