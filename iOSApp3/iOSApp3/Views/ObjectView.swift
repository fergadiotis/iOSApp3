//
//  ObjectView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import SwiftUI
import MapKit

struct ObjectView: View {
    let object: Object
    @State private var showingSafari = false
    @State private var showingShareSheet = false
    @State private var showingMap = false
    
    // Sample coordinates for Hamilton Museum
    private let museumLocation = CLLocationCoordinate2D(latitude: 43.2557, longitude: -79.8711)
    
    var body: some View {
        // Use GeometryReader to work with available space
        GeometryReader { geometry in
            ZStack {
                // Background image
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.3),
                                Color.black.opacity(0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .edgesIgnoringSafeArea(.all)
                    )
                
                // Content container - Full height ScrollView
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 16) {
                        // Title Card
                        Text(object.title)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    Color.black.opacity(0.5)
                                    Rectangle()
                                        .strokeBorder(Color.hamiltonAccent, lineWidth: 1)
                                        .padding(1)
                                }
                            )
                            .cornerRadius(8)
                        
                        // Image container
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.2))
                                .shadow(radius: 4)
                            
                            getLocalImage(forObject: object)
                                .padding(12)
                        }
                        .frame(height: geometry.size.height * 0.25) // Relative height
                        .padding(.horizontal, 16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.hamiltonAccent, lineWidth: 1)
                                .padding(1)
                        )
                        
                        // About section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About this item")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                            
                            // Collection info
                            Text(object.creditLine)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black.opacity(0.5))
                                )
                                .cornerRadius(8)
                            
                            // Description text - Key changes for text display
                            if let additionalInfo = getAdditionalInfo(forObject: object) {
                                Text(additionalInfo)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true) // Important for text wrapping
                                    .lineLimit(nil) // No line limit
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.leading)
                                    .padding(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black.opacity(0.4))
                                    )
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer(minLength: 16)
                        
                        // Action Buttons
                        HStack(spacing: 20) {
                            // Website Button
                            Button(action: {
                                if let url = URL(string: object.objectURL) {
                                    showingSafari = true
                                }
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: "globe")
                                        .font(.system(size: 16))
                                    Text("Website")
                                        .font(.system(size: 12))
                                }
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 0.4, green: 0.3, blue: 0.2).opacity(0.85))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .strokeBorder(Color.hamiltonAccent, lineWidth: 1)
                                        )
                                )
                            }
                            .sheet(isPresented: $showingSafari) {
                                if let url = URL(string: object.objectURL) {
                                    SafariView(url: url)
                                }
                            }
                            
                            // Share Button
                            Button(action: {
                                showingShareSheet = true
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 16))
                                    Text("Share")
                                        .font(.system(size: 12))
                                }
                                .frame(width: 60, height: 60)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.hamiltonAccent)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .strokeBorder(Color.white, lineWidth: 1)
                                        )
                                )
                            }
                            .sheet(isPresented: $showingShareSheet) {
                                let shareText = "Check out this item from Hamilton Museum: \(object.title). \(object.objectURL)"
                                ActivityViewController(activityItems: [shareText])
                            }
                            
                            // Map Button
                            Button(action: {
                                showingMap = true
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: "map")
                                        .font(.system(size: 16))
                                    Text("Map")
                                        .font(.system(size: 12))
                                }
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(red: 0.4, green: 0.3, blue: 0.2).opacity(0.85))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .strokeBorder(Color.hamiltonAccent, lineWidth: 1)
                                        )
                                )
                            }
                            .sheet(isPresented: $showingMap) {
                                VersionAdaptiveMuseumMapView(coordinate: museumLocation, title: "Hamilton Museum")
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 12)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Helper function to get the appropriate local image for each object
    func getLocalImage(forObject object: Object) -> some View {
        // Try to load actual images, with SF Symbols as fallback
        switch object.objectID {
        case 1001:
            return AnyView(
                Image("Hamilton Steam Engine")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black.opacity(0.3))
            )
        case 1002:
            return AnyView(
                Image("vic1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black.opacity(0.3))
            )
        case 1003:
            return AnyView(
                Image("Indigenous Wampum Belt")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black.opacity(0.3))
            )
        case 1004:
            return AnyView(
                Image("Early Hamilton street map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black.opacity(0.3))
            )
        case 1005:
            return AnyView(
                Image("Steel work")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black.opacity(0.3))
            )
        default:
            return AnyView(
                Image(systemName: "photo")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
            )
        }
    }
    
    // Helper function to get additional information for each object
    func getAdditionalInfo(forObject object: Object) -> String? {
        switch object.objectID {
        case 1001:
            return "This impressive steam engine represents Hamilton's rich industrial heritage. Built in 1890, it showcases the engineering prowess that helped establish the city as a manufacturing center."
        case 1002:
            return "This exquisite Victorian Era dress exemplifies the fashion of the 1870s, with its bustled silhouette and elaborate detailing. The piece features fine silk fabric with intricate embroidery typical of formal evening wear during this period."
        case 1003:
            return "This significant Indigenous wampum belt represents treaties and agreements between First Nations peoples. These belts use purple and white beads arranged in meaningful patterns to record important historical events and relationships."
        case 1004:
            return "This remarkable street map from 1850 offers a fascinating glimpse into Hamilton's early urban development. It shows the original street layout and geographical features that shaped the growing city."
        case 1005:
            return "This collection of photographs documents the daily lives and working conditions of steel workers in Hamilton between 1920-1940. These images provide valuable historical insight into the industrial labor that built the city's economy."
        default:
            return nil
        }
    }
}
