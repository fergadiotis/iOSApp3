//
//  ContentView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = RomStore()
    @State private var query = ""
    @State private var showQueryField = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image that completely fills screen
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.3),
                                Color.black.opacity(0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                    )
                
                // Content container
                VStack(spacing: 0) {
                    Spacer(minLength: 140)
                    
                    // Search Results Indicator
                    if !query.isEmpty {
                        HStack {
                            Text("Showing results for '\(query)'")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                query = ""
                                store.createDevData()
                            }) {
                                Text("Clear")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.hamiltonBackground)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                    
                    if isLoading {
                        Spacer()
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.hamiltonAccent))
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        Spacer()
                    } else if store.objects.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.white)
                            
                            Text("No items found")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            Text("Try adjusting your search query")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Button("Reset Collection") {
                                store.createDevData()
                            }
                            .font(.system(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.hamiltonBackground)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        Spacer()
                    } else {
                        // Main content list - Takes full width
                        ScrollView(showsIndicators: true) {
                            LazyVStack(spacing: 10) {
                                ForEach(store.objects, id: \.objectID) { object in
                                    NavigationLink(destination: ObjectView(object: object)) {
                                        HStack(spacing: 12) {
                                            // Thumbnail with proper container
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(Color.black.opacity(0.6))
                                                    .frame(width: 60, height: 60)
                                                
                                                getLocalImage(forObject: object)
                                            }
                                            
                                            // Text with adjusted fonts
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(object.title)
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.white)
                                                    .lineLimit(1)
                                                
                                                Text(object.creditLine)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.white.opacity(0.9))
                                                    .lineLimit(1)
                                            }
                                            
                                            Spacer()
                                            
                                            // Chevron with adjusted size
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 14)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(red: 0.4, green: 0.4, blue: 0.4).opacity(0.5))
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 3)
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 40) // Extra bottom padding to prevent cut-off
                        }
                    }
                }
            }
            .navigationTitle("Hamilton Museum")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showQueryField = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
            }
            .alert("Search Hamilton Museum", isPresented: $showQueryField) {
                TextField("Enter search term", text: $query)
                Button("Search") {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        store.search(query: query)
                        isLoading = false
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter a keyword to search the collection")
            }
        }
        .accentColor(.white)
    }
    
    // Helper function to get the appropriate local image for each object
    func getLocalImage(forObject object: Object) -> some View {
        // Try to load actual images, with SF Symbols as fallback
        switch object.objectID {
        case 1001:
            return AnyView(
                Image("Hamilton Steam Engine")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56) // Slightly smaller to fit container
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        case 1002:
            return AnyView(
                Image("vic1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        case 1003:
            return AnyView(
                Image("Indigenous Wampum Belt")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        case 1004:
            return AnyView(
                Image("Early Hamilton street map")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        case 1005:
            return AnyView(
                Image("Steel work")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            )
        default:
            return AnyView(
                Image(systemName: "photo")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
            )
        }
    }
}
