//
//  PageIndicatorStyle.swift
//  CarouselView
//
//  Created by Abhishek Agarwal on 02/08/25.
//

import SwiftUI

struct PageIndicatorStyle {
    let activeColor: Color
    let inactiveColor: Color
    let activeSize: CGFloat
    let inactiveScale: CGFloat
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let topPadding: CGFloat
    
    static let `default` = PageIndicatorStyle(
        activeColor: .gray,
        inactiveColor: .gray.opacity(0.5),
        activeSize: 10,
        inactiveScale: 0.8,
        spacing: 8,
        horizontalPadding: 12,
        verticalPadding: 8,
        topPadding: 16
    )
}


// MARK: - Page Indicator Component
struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int
    let style: PageIndicatorStyle
    
    var body: some View {
        HStack(spacing: style.spacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? style.activeColor : style.inactiveColor)
                    .frame(
                        width: style.activeSize,
                        height:  style.activeSize
                    )
                    .scaleEffect(index == currentPage ? 1.0 : 0.8)
                    .animation(.easeInOut(duration: 0.2), value: currentPage)
            }
        }
        .padding(.horizontal, style.horizontalPadding)
        .padding(.vertical, style.verticalPadding)
    }
}
