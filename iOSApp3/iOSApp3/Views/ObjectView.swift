//
//  ObjectView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import SwiftUI

struct ObjectView: View {
    let object: Object
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let url = URL(string: object.objectURL) {
                    Link(destination: url) {
                        WebIndicatorView(title: object.title)
                            .multilineTextAlignment(.leading)
                            .font(.callout)
                            .frame(minHeight: 44)
                            .padding()
                            .background(Color.hamiltonBackground)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Text(object.title)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .frame(minHeight: 44)
                }

                if object.isPublicDomain {
                    if let imageUrl = URL(string: object.primaryImageSmall) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                        } placeholder: {
                            PlaceholderView(note: "Loading image...")
                        }
                    }
                } else {
                    PlaceholderView(note: "Not in public domain")
                }

                Text(object.creditLine)
                    .font(.caption)
                    .padding()
                    .background(Color.hamiltonForeground)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ObjectView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectView(object: Object(
            objectID: 1001,
            title: "Hamilton Steam Engine",
            creditLine: "Test Credit",
            objectURL: "https://www.hamilton.ca/things-do/hamilton-civic-museums/hamilton-museum-steam-technology-national-historic-site",
            isPublicDomain: true,
            primaryImageSmall: "https://example.com/image.jpg"
        ))
    }
}
