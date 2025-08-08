import SwiftUI

struct MyAccountView: View {
    @Binding var favoriteRecipes: [Recipe]
    @StateObject var viewModel = MyAccountViewModel()

    private let gridColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .topLeading) {
                        Image("Food")
                            .resizable()
                            .frame(height: 200)

                        HStack(spacing: 15) {
                            Button {
                                viewModel.showMenu.toggle()
                            } label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 20, height: 15)
                                    .foregroundStyle(.black)
                            }

                            Button {
                                viewModel.isClicked = true
                            } label: {
                                Image(systemName: "multiply")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.leading, 730)
                    }
                    .fullScreenCover(isPresented: $viewModel.isClicked) {
                        HomeView()
                    }

                    VStack(spacing: 8) {
                        Image("Profile")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .background(.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        Text("Jenny Doe")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Chef")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 32) {
                        VStack {
                            Text("12")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Recipes")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("10.6k")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        VStack {
                            Text("1.1k")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Following")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack(spacing: 16) {
                        Button {
                           
                        } label: {
                            Label("Edit Profile", systemImage: "highlighter")
                        }
                        .foregroundColor(.white)
                        .frame(height: 30)
                        .padding(.horizontal)
                        .background(Color.red)
                        .cornerRadius(6)

                        Button {
                        } label: {
                            Label("QR-Code", systemImage: "qrcode")
                        }
                        .foregroundColor(.red)
                        .frame(height: 30)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.red)
                        )
                    }

                    HStack {
                        Label("My Recipes", systemImage: "book.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top)

                    VStack(spacing: 12) {
                        if favoriteRecipes.isEmpty {
                            Text("You haven't favorited any recipes yet.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            LazyVGrid(columns: gridColumns, spacing: 12) {
                                ForEach(favoriteRecipes, id: \.id) { recipe in
                                    CategoriesCardView(
                                        recipe: recipe,
                                        categories: [], 
                                        favoriteRecipes: $favoriteRecipes
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 50)
            }

            if viewModel.showMenu {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.showMenu = false }

                VStack {
                    Spacer()
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "gearshape")
                            Text("App Settings")
                        }

                        Divider().background(.white)

                        HStack {
                            Image(systemName: "person")
                            Text("Accounts")
                        }

                        Divider().background(.white)

                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Button {
                                viewModel.showMenu = false
                                viewModel.navigateToWelcome = true
                            } label: {
                                Text("Sign Out!!")
                            }
                        }
                    }
                    .padding()
                    .frame(width: 280)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToWelcome) {
            WelcomeView()
                .navigationBarBackButtonHidden()
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    MyAccountView(favoriteRecipes: .constant([]))
}
