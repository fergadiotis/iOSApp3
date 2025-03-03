//
//  Color+Extensions.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import SwiftUI

extension Color {
    // Hamilton Museum color scheme that complements the building background
    static let hamiltonBrown = Color(red: 0.4, green: 0.3, blue: 0.2)          // Warm brown like the building
    static let hamiltonCream = Color(red: 0.95, green: 0.9, blue: 0.8)         // Cream color from stonework
    static let hamiltonDarkBlue = Color(red: 0.1, green: 0.2, blue: 0.3)       // Deep blue accent color
    static let hamiltonGold = Color(red: 0.85, green: 0.7, blue: 0.3)          // Gold accent color
    static let hamiltonSlate = Color(red: 0.3, green: 0.3, blue: 0.35)         // Slate gray from the architecture
    
    // Map the app colors to theme
    static let hamiltonBackground = hamiltonBrown        // Main background color
    static let hamiltonForeground = hamiltonCream        // Main text color
    static let hamiltonAccent = hamiltonGold             // Accent color for highlights
    
    // Additional semantic colors
    static let hamiltonHeader = hamiltonDarkBlue         // Color for headers
    static let hamiltonSecondary = hamiltonSlate         // Secondary elements
}
