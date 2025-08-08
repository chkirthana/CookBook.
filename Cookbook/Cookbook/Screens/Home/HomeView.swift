import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var settings: settingsapp
    @StateObject var viewModel = HomeViewModel()

    let Categories: [String] = ["Cookies", "Cereal", "RiceCakes", "Noodles", "Paneer", "Carousel", "Bhibhimbap", "Breakfast", "Rice"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let column: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)

    var filteredRecipes: [Recipe] {
        if let cuisine = viewModel.selectedCuisine {
            return viewModel.allRecipes.filter { $0.cuisine == cuisine }
        } else {
            return viewModel.allRecipes
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(Color.black)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    NavbarView(
                        cuisines: viewModel.uniqueCuisines,
                        selectedCuisine: $viewModel.selectedCuisine,
                        favoriteRecipes: $viewModel.favoriteRecipes
                    )

                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(Array(Categories.enumerated()), id: \.element) { index, category in
                                    Image(category)
                                        .resizable()
                                        .frame(width: 750, height: 500)
                                        .id(index)
                                }
                            }
                        }
                        .onReceive(timer) { _ in
                            viewModel.currentindex += 1
                            if viewModel.currentindex >= Categories.count {
                                viewModel.currentindex = 0
                            }
                            withAnimation {
                                proxy.scrollTo(viewModel.currentindex, anchor: .center)
                            }
                        }
                    }
                    .padding()

                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: column) {
                            ForEach(filteredRecipes, id: \.id) { recipe in
                                NavigationLink(destination: RecipeView(recipe: recipe)) {
                                    CategoriesCardView(
                                        recipe: recipe,
                                        categories: Categories,
                                        favoriteRecipes: $viewModel.favoriteRecipes
                                    )
                                }
                                .buttonStyle(.plain) 
                            }
                        }
                    }
                }
            }
        }
        .task {
            await loadRecipes()
        }
        .onAppear() {
            settings.isLoggedIn.toggle()
        }
    }

    @MainActor
    func loadRecipes() async {
        do {
            let recipes = try await NetworkManagerView.shared.fetchRecipes()
            viewModel.allRecipes = recipes
            viewModel.uniqueCuisines = Array(Set(recipes.map { $0.cuisine })).sorted()
        } catch {
            print("Error loading recipes:", error)
        }
    }

}

#Preview {
    HomeView()
        .environmentObject(settingsapp())
}
