import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
            Text(recipe.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            Text("\(recipe.caloriesPerServing) calories")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack(spacing: 10) {
                Label("\(recipe.prepTimeMinutes) mins", systemImage: "clock")
                    .font(.caption)
                Label("Serves \(recipe.servings)", systemImage: "person.2")
                    .font(.caption)
            }
            .foregroundColor(.gray)
        }
        .frame(width: 160, height: 250)
        .padding()
        .border(Color.white, width: 0.25)
        .background(.black)
        .cornerRadius(5)
        .shadow(radius: 6)
    }
}
