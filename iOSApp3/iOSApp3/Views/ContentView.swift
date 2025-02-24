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
    
    var body: some View {
        NavigationStack {
            VStack {
                if !query.isEmpty {
                    Text("You searched for '\(query)'")
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                List(store.objects, id: \.objectID) { object in
                    if !object.isPublicDomain, let url = URL(string: object.objectURL) {
                        NavigationLink {
                            SafariView(url: url)
                        } label: {
                            WebIndicatorView(title: object.title)
                        }
                        .listRowBackground(Color.hamiltonBackground)
                        .foregroundColor(.white)
                    } else {
                        NavigationLink {
                            ObjectView(object: object)
                        } label: {
                            Text(object.title)
                        }
                        .listRowBackground(Color.hamiltonForeground)
                    }
                }
                .navigationTitle("Hamilton Museum")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showQueryField = true
                        } label: {
                            Text("Search Hamilton Museum")
                                .foregroundColor(Color.hamiltonBackground)
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.hamiltonBackground, lineWidth: 2)
                                )
                        }
                    }
                }
                .alert("Search Hamilton Museum", isPresented: $showQueryField) {
                    TextField("Enter search term", text: $query)
                    Button("Search") {
                        store.search(query: query)
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Enter a keyword to search the collection")
                }
            }
        }
    }
}
