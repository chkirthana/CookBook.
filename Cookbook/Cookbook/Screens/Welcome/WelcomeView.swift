import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Welcome")
                    .resizable()
                    .scaledToFill()
                    .clipShape(ContainerRelativeShape())
                    .ignoresSafeArea()
                
                VStack(spacing: 600) {
                    VStack {
                        Text("Welcome to Cookbook")
                            .font(.system(size: 40, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .frame(width: 180, height: 40)
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(.black)
                                .border(Color.black, width: 2)
                        }
                        .padding()

                        NavigationLink(destination: SignInView()) {
                            Text("Sign In")
                                .frame(width: 180, height: 40)
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(.black)
                                .border(Color.black, width: 2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(settingsapp())
}
