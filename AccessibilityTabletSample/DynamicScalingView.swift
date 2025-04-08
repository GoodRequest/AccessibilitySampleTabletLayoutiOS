import SwiftUI

struct DynamicScalingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 30) {
                    Text("Dynamic Scaling with GeometryReader")
                        .font(.largeTitle)
                        .padding()
                        .multilineTextAlignment(.center)

                    // Example 1: Basic GeometryReader Scaling
                    VStack {
                        Text("Text Size Scales with Screen Width")
                            .font(.headline)

                        Text("Hello, World!")
                            .font(.system(size: geometry.size.width / 10))
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .accessibilityHint("Text size automatically adjusts based on screen width")
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))


                    // Example 2: Scaling UI Elements
                    VStack {
                        Text("UI Elements Scale Proportionally")
                            .font(.headline)

                        HStack(spacing: geometry.size.width * 0.05) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(Color.blue.opacity(Double(index + 1) / 3))
                                    .frame(width: geometry.size.width * 0.25,
                                           height: geometry.size.width * 0.25)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .accessibilityLabel("Three circles of increasing opacity")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)

                    // Example 3: Responsive Card
                    VStack {
                        Text("Responsive Card Layout")
                            .font(.headline)

                        let isWide = geometry.size.width > 500

                        // Card switches between horizontal and vertical layout
                        if isWide {
                            HStack(spacing: 20) {
                                cardImage(width: geometry.size.width * 0.3)
                                cardContent
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        } else {
                            VStack(spacing: 20) {
                                cardImage(width: geometry.size.width * 0.6)
                                cardContent
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        }

                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Feature card showing adaptive layout based on available width")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)

                    // Device info display
                    VStack {
                        Text("Device Information")
                            .font(.headline)

                        Text("Size Class: \(horizontalSizeClass == .compact ? "Compact" : "Regular")")
                            .padding(.top, 5)

                        Text("Screen Width: \(Int(geometry.size.width)) points")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Dynamic Scaling")
    }
    
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Adaptive Card")
                .font(.title2)
                .bold()
            
            Text("This card layout changes between horizontal and vertical arrangement based on available width")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    private func cardImage(width: CGFloat) -> some View {
        Image(systemName: "rectangle.on.rectangle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .foregroundColor(.blue)
    }
}

struct DynamicScalingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DynamicScalingView()
            }
            .previewDevice("iPhone 13")
            .previewDisplayName("iPhone 13")
            
            NavigationView {
                DynamicScalingView()
            }
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewDisplayName("iPad Pro 11")
        }
    }
}
