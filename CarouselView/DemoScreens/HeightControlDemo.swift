//
//  HeightControlDemo.swift
//  CarouselView
//
//  Created by Abhishek Agarwal on 02/08/25.
//

import SwiftUI

//Boilerplate code
// MARK: - Height Control Demo
struct HeightControlDemo: View {
    @State private var height: CGFloat = 30
    @State private var imageItems: [ImageItem] = [
        ImageItem(image: Image(.img1), title: "Photo 1"),
        ImageItem(image: Image(.img2), title: "Photo 2"),
        ImageItem(image: Image(.img3), title: "Photo 3"),
        ImageItem(image: Image(.img4), title: "Photo 4"),
        ImageItem(image: Image(.img5), title: "Photo 5")
    ]
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Height Adjustable Carousel")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("Use the slider below to adjust carousel height")
                .font(.caption)
                .foregroundColor(.secondary)
            
            
            Text("Above Carousel")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            
            CarouselView(imageItems) { item in
                item.image
                    .resizable()
                    .overlay {
                        Text(item.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                    }
                
            }
            .padding(.horizontal)
            
            // Bottom Element
            Text("Below Carousel")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Height Control Slider
            VStack(spacing: 16) {
                HStack {
                    Text("Height: \(Int(height))pt")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button("Reset") {
                        withAnimation(.spring()) {
                            height = 250
                        }
                    }
                    .foregroundColor(.blue)
                }
                
                HStack {
                    Text("30")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Slider(value: $height, in: 30...150, step: 10) {
                        Text("Height")
                    }
                    .accentColor(.blue)
                    
                    Text("150")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}
