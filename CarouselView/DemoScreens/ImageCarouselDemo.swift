//
//  ImageCarouselDemo.swift
//  CarouselView
//
//  Created by Abhishek Agarwal on 02/08/25.
//

import SwiftUI

//Boilerplate COde
// MARK: - Image Carousel Demo
struct ImageCarouselDemo: View {
    @State private var imageItems: [ImageItem] = [
        ImageItem(image: Image(.img1), title: "Photo 1"),
        ImageItem(image: Image(.img2), title: "Photo 2"),
        ImageItem(image: Image(.img3), title: "Photo 3"),
        ImageItem(image: Image(.img4), title: "Photo 4"),
        ImageItem(image: Image(.img5), title: "Photo 5")
    ]
    
    private let availableImages = [
        ImageItem(image: Image(.img1), title: "Photo 1"),
        ImageItem(image: Image(.img2), title: "Photo 2"),
        ImageItem(image: Image(.img3), title: "Photo 3"),
        ImageItem(image: Image(.img4), title: "Photo 4"),
        ImageItem(image: Image(.img5), title: "Photo 5")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Interactive Image Carousel")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("Swipe to navigate • Tap buttons to add/remove items")
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Carousel
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
            
            // Control Buttons
            HStack(spacing: 20) {
                Button(action: addRandomImage) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Image")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .cornerRadius(25)
                }
                .disabled(imageItems.count >= 8)
                
                Button(action: removeLastImage) {
                    HStack {
                        Image(systemName: "minus.circle.fill")
                        Text("Remove Image")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .cornerRadius(25)
                }
                .disabled(imageItems.count <= 3)
            }
            
            Text("Current Items: \(imageItems.count)")
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
            
            
            
        }
    }
    
    private func addRandomImage() {
        let randomImage = availableImages.randomElement()!
        
        withAnimation(.spring()) {
            imageItems.append(randomImage)
        }
    }
    
    private func removeLastImage() {
        guard imageItems.count > 1 else { return }
        
        withAnimation(.spring()) {
            let _ = imageItems.removeLast()
        }
    }
}
