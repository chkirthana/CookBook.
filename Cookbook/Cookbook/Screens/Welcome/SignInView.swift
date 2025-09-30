import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject var settings: settingsapp
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        ZStack {
            Image("Sign In")
                .resizable()
                .scaledToFill()
                .clipShape(ContainerRelativeShape())
            VStack {
                Text("Welcome to Cookbook")
                    .font(.system(size: 27, weight: .semibold, design: .default))
                Image("Cookbook (Sign In)")
                    .resizable()
                    .frame(width: 250, height: 150)
                    .padding()
                VStack(spacing: 20) {
                    Text("Sign In")
                        .font(.system(size: 25, weight: .light, design: .default))
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .frame(width: 350, height: 50)
                        .foregroundStyle(.black)
                        .background(Color.white)
                        .border(Color.gray, width: 1)
                        .cornerRadius(5)
                    HStack {
                        if viewModel.issecured {
                            SecureField("Password", text: $viewModel.password)
                            } else {
                                TextField("Password", text: $viewModel.password)
                            }
                            
                            Button {
                                viewModel.issecured.toggle()
                            } label: {
                                Image(systemName: viewModel.issecured ? "eye.slash" : "eye")
                                    .resizable()
                                    .frame(width: 30, height: 20)
                                    .foregroundStyle(.black)
                            }
                        
                    }
                    .padding()
                    .frame(width: 350, height: 50)
                    .foregroundStyle(.black)
                    .background(Color.white)
                    .border(Color.gray, width: 1)
                    .cornerRadius(5)
                    Button {
                        resetallfields()
                        viewModel.showHome = true
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(Color.black)
                    }
                    .fullScreenCover(isPresented: $viewModel.showHome) {
                        HomeView()
                    }
                    HStack(spacing: 10) {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .font(.headline)
                        }
                    }
                }
            }
            .frame(width: 550, height: 700)
            .border(Color.gray)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
    func resetallfields() {
        viewModel.email = ""
        viewModel.password = ""
   }
}

#Preview {
        SignInView()
            .environmentObject(settingsapp())

}
