//
//  MuseumImageView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-03-01.
//

import SwiftUI

struct MuseumImageView: View {
    let imageUrl: String
    let objectID: Int
    @State private var imageLoadingError = false
    @State private var isImageLoading = true
    
    var body: some View {
        // Check if we have a local image for this object
        if objectID == 1002 {
            // Use the Victorian dress image from assets
            Image("vic1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)
                .shadow(radius: 5)
                .frame(height: 250)
        } else if let url = URL(string: imageUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle()
                            .fill(Color.hamiltonForeground.opacity(0.3))
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.hamiltonAccent))
                            .scaleEffect(1.5)
                    }
                    .frame(height: 250)
                    .cornerRadius(12)
                    .onAppear {
                        isImageLoading = true
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .onAppear {
                            isImageLoading = false
                            imageLoadingError = false
                        }
                case .failure:
                    ZStack {
                        Rectangle()
                            .fill(Color.hamiltonForeground.opacity(0.3))
                        VStack {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(Color.hamiltonBackground)
                            Text("Image Unavailable")
                                .font(.headline)
                                .padding(.top, 8)
                        }
                    }
                    .frame(height: 250)
                    .cornerRadius(12)
                    .onAppear {
                        isImageLoading = false
                        imageLoadingError = true
                    }
                @unknown default:
                    Text("Unknown state")
                }
            }
        } else {
            ZStack {
                Rectangle()
                    .fill(Color.hamiltonForeground.opacity(0.3))
                Text("Invalid Image URL")
                    .font(.headline)
            }
            .frame(height: 250)
            .cornerRadius(12)
        }
    }
}
