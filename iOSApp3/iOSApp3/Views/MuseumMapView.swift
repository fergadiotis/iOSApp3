//
//  MuseumMapView.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-03-01.
//

import SwiftUI
import MapKit

// Updated MapAnnotation struct to conform to Identifiable
struct MapAnnotation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let title: String
}

// Updated MuseumMapView using the new iOS 17+ Map API
struct MuseumMapView: View {
    let coordinate: CLLocationCoordinate2D
    let title: String
    @State private var position: MapCameraPosition
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        self._position = State(initialValue: MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
    }
    
    var body: some View {
        VStack {
            Text("Museum Location")
                .font(.headline)
                .padding()
            
            Map(position: $position) {
                // This replaces the deprecated MapMarker
                Marker(title, coordinate: coordinate)
                    .tint(Color.hamiltonBackground)
            }
            .mapControlVisibility(.visible)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// The MapMarker-specific variant for iOS versions before 17.0
@available(iOS, introduced: 13.0, deprecated: 17.0, message: "Use Marker instead")
struct LegacyMuseumMapView: View {
    let coordinate: CLLocationCoordinate2D
    let title: String
    @State private var region: MKCoordinateRegion
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        self._region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        VStack {
            Text("Museum Location")
                .font(.headline)
                .padding()
            
            Map(coordinateRegion: $region, annotationItems: [MapAnnotation(id: UUID(), coordinate: coordinate, title: title)]) { item in
                MapMarker(coordinate: item.coordinate, tint: Color.hamiltonBackground)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// A version-adaptive wrapper that uses the appropriate implementation based on iOS version
struct VersionAdaptiveMuseumMapView: View {
    let coordinate: CLLocationCoordinate2D
    let title: String
    
    var body: some View {
        if #available(iOS 17.0, *) {
            MuseumMapView(coordinate: coordinate, title: title)
        } else {
            LegacyMuseumMapView(coordinate: coordinate, title: title)
        }
    }
}
