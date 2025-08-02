//
//  ContentView.swift
//  CarouselView
//
//  Created by Abhishek Agarwal on 02/08/25.
//

import SwiftUI

// MARK: - Demo Models
struct ImageItem: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
}

// MARK: - Demo Views
enum CarouselDemoTab: CaseIterable {
    case images
    case heightControl
    
    var icon: String {
        switch self {
            case .images: return "photo.stack"
            case .heightControl: return "slider.horizontal.3"
        }
    }
}

// MARK: - Main Demo Screen
struct ContentView: View {
    @State private var selectedTab: CarouselDemoTab = .images
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Segment Control
                Picker("Demo Type", selection: $selectedTab) {
                    ForEach(CarouselDemoTab.allCases, id: \.self) { tab in
                        Image(systemName: tab.icon)
                            .tag(tab)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content
                switch selectedTab {
                    case .images:
                        ImageCarouselDemo()
                    case .heightControl:
                        HeightControlDemo()
                }
                
                Spacer()
            }
            .navigationTitle("Carousel Demo")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}







