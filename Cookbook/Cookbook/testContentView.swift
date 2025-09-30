//
//  testContentView.swift
//  Cookbook
//
//  Created by Reddy Bharadwaj Chowdary on 09/09/25.
//
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct testContentView: View {
    @StateObject private var viewModel = GoogleAuthViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if let profile = viewModel.profile {
                // ✅ User is signed in
                VStack(spacing: 12) {
                    if let url = profile.imageURL {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    Text("Welcome, \(profile.name)")
                        .font(.title2)
                        .bold()
                    Text(profile.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button("Sign Out") {
                        viewModel.signOut()
                    }
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            } else {
                // ❌ User not signed in
                GoogleSignInButton {
                    Task {
                        await viewModel.signIn()
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 40)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    testContentView()
}
