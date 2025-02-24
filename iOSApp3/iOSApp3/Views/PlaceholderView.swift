//
//  PlaceholderView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import SwiftUI

struct PlaceholderView: View {
    let note: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .inset(by: 7)
                .fill(Color.hamiltonForeground)
                .frame(height: 200)
                .overlay(
                    Rectangle()
                        .stroke(Color.hamiltonBackground, lineWidth: 7)
                        .padding(7)
                )
                .padding()
            
            Text(note)
                .foregroundColor(Color.hamiltonBackground)
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(note: "Test placeholder")
    }
}
