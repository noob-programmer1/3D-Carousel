//
//  CarouselView.swift
//  CarouselView
//
//  Created by Abhishek Agarwal on 02/08/25.
//

import SwiftUI

//MARK: - CarouselConfiguration
struct CarouselConfiguration {
    let defaultMaxHeight: CGFloat
    let minHeight: CGFloat
    let spacingMultiplier: CGFloat
    let scaleReduction: CGFloat
    let rotationAngle: CGFloat
    let dragThreshold: CGFloat
    let velocityThreshold: CGFloat
    let pageIndicationStyle: PageIndicatorStyle?
    let pageIndicatorSpacing: CGFloat
    
    
    
    static let `default`: Self = .init(defaultMaxHeight: 250,
                                       minHeight: 100,
                                       spacingMultiplier: 0.78,
                                       scaleReduction: 0.49,
                                       rotationAngle: 15,
                                       dragThreshold: 0.5,
                                       velocityThreshold: 400,
                                       pageIndicationStyle: .default,
                                       pageIndicatorSpacing: 8)
    
    
}


// MARK: - CarouselView
struct CarouselView<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    
    // Configuration
    let config: CarouselConfiguration
    
    // MARK: - Properties
    let data: Data
    let id: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content
    
    // State
    @State private var currentIndex: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    
    // MARK: - Computed Properties
    private var dataArray: [Data.Element] {
        Array(data)
    }
    
    private var dataCount: Int {
        dataArray.count
    }
    
    init(
        config: CarouselConfiguration = .default,
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.config = config
        self.data = data
        self.id = id
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: config.pageIndicatorSpacing) {
            
            GeometryReader { geometry in
                
                let availableHeight = max(min(geometry.size.height, config.defaultMaxHeight), config.minHeight)
                let screenWidth = geometry.size.width
                let centerX = screenWidth / 2
                let cardSize = availableHeight
                
                
                let minSpacing: CGFloat = 60
                let calculatedSpacing = cardSize * config.spacingMultiplier
                let actualSpacing = max(minSpacing, calculatedSpacing)
                
                let rotationScale = min(1.0, cardSize / 200.0)
                let adjustedRotationAngle = config.rotationAngle * rotationScale
                
                let minScale: CGFloat = cardSize < 180 ? 0.85 : 0.7
                
                ZStack {
                    ForEach(Array(dataArray.enumerated()), id: \.offset) { index, item in
                        
                        let indexOffset = CGFloat(index) - currentIndex
                        let totalOffset = indexOffset * actualSpacing + dragOffset
                        let distance = abs(totalOffset) / cardSize
                        
                        // Visual effects calculations
                        let scale = calculateImprovedScale(for: distance, minScale: minScale)
                        let zIndex = calculateZIndex(for: distance)
                        let rotation = distance * adjustedRotationAngle
                        
                        // Offset calculation
                        let xOffset = centerX + totalOffset - cardSize / 2
                        
                        content(item)
                            .frame(width: cardSize, height: cardSize)
                            .aspectRatio(1, contentMode: .fill)
                            .clipped()
                            .cornerRadius(min(20, cardSize * 0.1))
                            .scaleEffect(scale)
                            .rotation3DEffect(
                                .degrees(totalOffset > 0 ? -rotation : rotation),
                                axis: (x: 0, y: 1, z: 0),
                                perspective: cardSize < 180 ? 0.3 : 0.2
                            )
                            .offset(x: xOffset)
                            .zIndex(zIndex)
                            .animation(
                                .spring(response: 0.6, dampingFraction: 0.8),
                                value: currentIndex
                            )
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            handleDragEnd(value: value, spacing: actualSpacing)
                        }
                )
            }
            .frame(minHeight: config.minHeight, maxHeight: config.defaultMaxHeight)
            .onAppear {
                if dataCount > 0 {
                    currentIndex = CGFloat(dataCount/2)
                }
            }
            
            if let pageIndicationStyle = config.pageIndicationStyle {
                PageIndicator(currentPage: .init(currentIndex), totalPages: dataCount, style: pageIndicationStyle)
            }
        }
    }
    
    // MARK: - Helper Methods
    private func calculateImprovedScale(for distance: CGFloat, minScale: CGFloat) -> CGFloat {
        if distance < 1 {
            let baseScale = 1.0 - distance * config.scaleReduction
            return max(minScale, baseScale)
        } else {
            return max(minScale, 1.0 - config.scaleReduction)
        }
    }
    
    private func calculateZIndex(for distance: CGFloat) -> Double {
        return distance < 0.01 ? 100.0 : (100.0 - distance * 10)
    }
    
    private func handleDragEnd(value: DragGesture.Value, spacing: CGFloat) {
        let threshold = spacing * 0.3
        let velocity = value.predictedEndTranslation.width - value.translation.width
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            if value.translation.width > threshold || velocity > config.velocityThreshold {
                currentIndex = max(0, currentIndex - 1)
            } else if value.translation.width < -threshold || velocity < -config.velocityThreshold {
                currentIndex = min(CGFloat(dataCount - 1), currentIndex + 1)
            }
            dragOffset = 0
        }
    }
    
}


// MARK: - Convenience Initializer for Identifiable Data
extension CarouselView where Data.Element: Identifiable, ID == Data.Element.ID {
    init(
        config: CarouselConfiguration = .default,
        _ data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.init(config: config,data, id: \.id, content: content)
    }
}
