import SwiftUI
import Combine
import GoogleSignIn
import UIKit

@main
struct CookbookApp: App {
    @State var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            Group {

                if isLoggedIn {

                    HomeView()
                        .environmentObject(settingsapp())
                }
                else {
                    testContentView()
              ///      WelcomeView()
                        .environmentObject(settingsapp())
                }
            }
            .onAppear {
                      // Restore previous session if available
                      GIDSignIn.sharedInstance.restorePreviousSignIn { _, _ in }
                    }
            .onOpenURL { url in
                      // Handle redirect
                      GIDSignIn.sharedInstance.handle(url)
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



extension UIApplication {
  static var topViewController: UIViewController? {
    guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let root = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
    else { return nil }
    var top = root
    while let presented = top.presentedViewController {
      top = presented
    }
    return top
  }
}
