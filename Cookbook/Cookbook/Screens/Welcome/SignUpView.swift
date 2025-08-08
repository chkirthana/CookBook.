import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @EnvironmentObject var settings: settingsapp
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Sign Up")
                    .resizable()
                    .scaledToFill()
                    .clipShape(ContainerRelativeShape())
                    .ignoresSafeArea()

                VStack {
                    Text("Hello \(viewModel.displayedUsername)!")
                        .font(.system(size: 27, weight: .semibold, design: .default))
                        .foregroundStyle(.black)
                        .padding(.top)

                    Image("Cookbook (Sign In)")
                        .resizable()
                        .frame(width: 250, height: 150)
                        .padding()

                    VStack(spacing: 20) {
                        Text("Sign Up")
                            .font(.system(size: 25, weight: .light, design: .default))
                            .foregroundStyle(.black)

                        TextField("Username", text: $settings.username)
                            .padding()
                            .frame(width: 350, height: 50)
                            .foregroundStyle(.black)
                            .background(Color.white)
                            .border(Color.gray, width: 1)
                            .cornerRadius(5)
                        
                        TextField("Email", text: $settings.email)
                            .padding()
                            .frame(width: 350, height: 50)
                            .foregroundStyle(.black)
                            .background(Color.white)
                            .border(Color.gray, width: 1)
                            .cornerRadius(5)
                        
                        HStack {
                            if viewModel.issecured {
                                SecureField("Password", text: $settings.password)
                                } else {
                                    TextField("Password", text: $settings.password)
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
                            viewModel.displayedUsername = settings.username.isEmpty ? "User" : settings.username
                            resetallfields()
                            viewModel.showSignIn = true
                        } label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 50)
                                .background(Color.black)
                        }
                        .fullScreenCover(isPresented: $viewModel.showSignIn) {
                            SignInView()
                        }
                        
                        
                        HStack(spacing: 10) {
                            Text("Already have an account?")
                                .foregroundColor(.gray)

                            NavigationLink(destination: SignInView()) {
                                Text("Sign In")
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
    }
    
     func resetallfields() {
        settings.username = ""
        settings.email = ""
        settings.password = ""
    }
}

#Preview {
    SignUpView()
        .environmentObject(settingsapp())
}
