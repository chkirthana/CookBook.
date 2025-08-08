import SwiftUI

struct NavbarView: View {
    let cuisines: [String]
    @Binding var selectedCuisine: String?
    @Binding var favoriteRecipes: [Recipe]

    var body: some View {
        HStack {
            Image("Cookbook")
                .resizable()
                .frame(width: 70, height: 60)
                .padding(.trailing, 300)

            Button("Home") {}
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 100, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )

            Button("About") {}
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 100, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )

            Menu {
                ForEach(cuisines, id: \.self) { cuisine in
                    Button(action: {
                        selectedCuisine = cuisine
                    }) {
                        Text(cuisine)
                    }
                }
                Button("All Cuisines") {
                    selectedCuisine = nil
                }
            } label: {
                Label(selectedCuisine ?? "Menu", systemImage: "chevron.down")
                    .frame(width: 130, height: 30)
                    .background(Color.black)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }

            NavigationLink(destination: MyAccountView(favoriteRecipes: $favoriteRecipes)) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.white)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
