import SwiftUI

struct CategoriesCardView: View {
    let recipe: Recipe
    let categories: [String]
    @Binding var favoriteRecipes: [Recipe]

    var isFavorite: Bool {
        favoriteRecipes.contains(where: { $0.id == recipe.id })
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                CacheImage(url: recipe.image, width: 160, height: 150)
                    .clipShape(Circle())
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 18)
                        .foregroundColor(isFavorite ? .red : .white)
                        .padding(8)
                }
                .background(Circle().fill(Color.black.opacity(0.6)))
                .offset(x: -8, y: 8)
                .buttonStyle(.plain)
            }

            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 5)

            Text(recipe.cuisine)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .cornerRadius(12)
        .background(Color.clear)
        .contentShape(Rectangle())
    }

    private func toggleFavorite() {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        } else {
            favoriteRecipes.append(recipe)
        }
    }
}

