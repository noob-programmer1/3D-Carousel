# SwiftUI 3D Carousel

A beautiful, customizable 3D carousel component for SwiftUI with smooth animations, drag gestures, and dynamic height adjustment.

![Carousel Demo](https://github.com/user-attachments/assets/8f6f852a-b60a-4425-99ed-f4ca15040b9a)

## Features

✨ **3D Visual Effects** - Cards rotate and scale with perspective transforms  
🎯 **Smooth Animations** - Spring-based animations with customizable parameters  
👆 **Intuitive Gestures** - Drag to navigate with velocity-based snapping  
📐 **Dynamic Height Adjustment** - Height adjusts dynamically based on content above and below it  
🎨 **Customizable** - Configure spacing, scaling, rotation, and colors  
📍 **Page Indicators** - Optional page indicators with custom styling  


## Configuration

### CarouselConfiguration

Customize the carousel behavior using `CarouselConfiguration`:

### Configuration Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `defaultMaxHeight` | `CGFloat` | `250` | Maximum height for carousel cards |
| `minHeight` | `CGFloat` | `100` | Minimum height for carousel cards |
| `spacingMultiplier` | `CGFloat` | `0.78` | Spacing between cards |
| `scaleReduction` | `CGFloat` | `0.49` | Scale reduction for side cards |
| `rotationAngle` | `CGFloat` | `15` | 3D rotation angle in degrees |
| `dragThreshold` | `CGFloat` | `0.5` | Minimum drag distance to trigger page change |
| `velocityThreshold` | `CGFloat` | `400` | Velocity threshold for quick swipes |
| `pageIndicationStyle` | `PageIndicatorStyle?` | `.default` | Page indicator styling |
| `pageIndicatorSpacing` | `CGFloat` | `8` | Space between carousel and indicators |

```swift
let customConfig = CarouselConfiguration(
    defaultMaxHeight: 300,        // Maximum card height
    minHeight: 150,              // Minimum card height
    spacingMultiplier: 0.8,      // Card spacing 
    scaleReduction: 0.3,         // How much side cards scale down
    rotationAngle: 20,           // 3D rotation angle in degrees
    dragThreshold: 0.4,          // Drag sensitivity 
    velocityThreshold: 300,      // Velocity needed for quick swipe
    pageIndicationStyle: .custom, // Page indicator style
    pageIndicatorSpacing: 12     // Space between carousel and indicators
)

CarouselView(config: customConfig, items, id: \.self) { item in
    // Your content here
}
```



### PageIndicatorStyle

```swift
struct PageIndicatorStyle {
    let activeColor: Color             // Active dot color (default: .gray)
    let inactiveColor: Color           // Inactive dot color (default: .gray.opacity(0.5))
    let activeSize: CGFloat            // Dot size (default: 10)
    let inactiveScale: CGFloat         // Inactive dot scale (default: 0.8)
    let spacing: CGFloat               // Space between dots (default: 8)
    let horizontalPadding: CGFloat     // Horizontal padding (default: 12)
    let verticalPadding: CGFloat       // Vertical padding (default: 8)
    let topPadding: CGFloat            // Top spacing from carousel (default: 16)
}

// Usage
let indicatorStyle = PageIndicatorStyle(
    activeColor: .blue,
    inactiveColor: .blue.opacity(0.3),
    activeSize: 12
)
```

## Basic Usage

Works with any data type - see `DemoScreens` for complete examples:

```swift
// With String array
let items = ["🍎", "🍊", "🍌", "🍇", "🍓"]
CarouselView(items, id: \.self) { item in
    Text(item).font(.system(size: 60))
}

// With custom objects (Identifiable)
struct Photo: Identifiable {
    let id = UUID()
    let name: String
}

let photos = [Photo(name: "sunset"), Photo(name: "mountain")]
CarouselView(photos) { photo in
    Image(photo.name).resizable()
}

// With custom configuration
CarouselView(config: customConfig, items, id: \.self) { item in
    // Your custom content
}
```}
```
