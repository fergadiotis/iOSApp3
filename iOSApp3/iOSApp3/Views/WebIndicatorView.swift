//
//  WebIndicatorView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import SwiftUI

struct WebIndicatorView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "arrow.up.right.square")
                .font(.footnote)
        }
    }
}
