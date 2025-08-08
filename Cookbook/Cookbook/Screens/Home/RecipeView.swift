import SwiftUI

struct RecipeView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)

                        CacheImage(url: recipe.image, width: 160, height: 150)
                            .clipShape(Circle())
                    }
                    .padding(.top, 30)

                    VStack(spacing: 8) {
                        Text(recipe.name)
                            .font(.title.bold())
                            .foregroundColor(.white)

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.yellow)

                            Text("\(recipe.rating, specifier: "%.1f")")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }

                        Text("\(recipe.caloriesPerServing) Calories")
                            .font(.subheadline)
                            .foregroundColor(.white)

                        Text("\(recipe.prepTimeMinutes) min prep, \(recipe.cookTimeMinutes) min cook")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.leading, 250)

                    HStack(spacing: 24) {
                        NutritionCard(title: "Calories", value: "\(recipe.caloriesPerServing)")
                        NutritionCard(title: "Carbs", value: "35")
                        NutritionCard(title: "Protein", value: "6.8")
                    }
                    .padding()
                    .border(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 24) {
   
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ingredients")
                                .font(.title3.bold())
                                .foregroundStyle(.white)

                            ForEach(recipe.ingredients, id: \.self) { item in
                                Text("• \(item)")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recipe Preparation")
                                .font(.title3.bold())
                                .foregroundStyle(.white)

                            ForEach(recipe.instructions, id: \.self) { step in
                                Text(step)
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 30)
                }
            }
        }
    }
}

struct NutritionCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.bold())
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
        .frame(width: 80, height: 60)
        .border(Color.white)
        .cornerRadius(10)
    }
}
