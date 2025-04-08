import SwiftUI

struct DynamicTypeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Dynamic Type Demonstration")
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                
                // Current Dynamic Type Info
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Dynamic Type Settings")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Size Category: \(sizeCategory.description)")
                            Text("Device Size Class: \(horizontalSizeClass == .compact ? "Compact" : "Regular")")
                        }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                }
                .padding(.horizontal)
                
                // Standard Text Styles Example
                VStack(alignment: .leading, spacing: 15) {
                    Text("Standard Text Styles")
                        .font(.headline)
                    
                    Group {
                        Text("Large Title").font(.largeTitle)
                        Text("Title").font(.title)
                        Text("Title 2").font(.title2)
                        Text("Title 3").font(.title3)
                        Text("Headline").font(.headline)
                        Text("Body").font(.body)
                        Text("Callout").font(.callout)
                        Text("Subheadline").font(.subheadline)
                        Text("Footnote").font(.footnote)
                        Text("Caption").font(.caption)
                    }
                    .padding(.leading)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                .padding(.horizontal)
                
                // Example: Dynamically Scaling UI
                VStack(alignment: .leading, spacing: 15) {
                    Text("Dynamically Scaling UI Elements")
                        .font(.headline)
                    
                    // Card that adapts to text size
                    adaptiveCard
                    
                    Text("Explanation:")
                        .font(.subheadline)
                        .padding(.top, 5)
                    
                    Text("This card's layout adapts based on both the device's size class and the user's preferred text size. On larger text sizes, it switches to vertical layout to accommodate the text.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                .padding(.horizontal)
                
                // Example: Minimal Scaling
                VStack(alignment: .leading, spacing: 15) {
                    Text("Controlled Scaling")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "textformat.size")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .accessibilityHidden(true)
                        
                        VStack(alignment: .leading) {
                            Text("Fixed Size Title")
                                .font(.system(size: 20))
                            
                            Text("This text uses a fixed size that won't scale with Dynamic Type")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Example showing text with fixed size that doesn't scale with Dynamic Type")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                .padding(.horizontal)
                
                // Best Practices
                VStack(alignment: .leading, spacing: 15) {
                    Text("Best Practices")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        bestPracticeRow(icon: "1.circle.fill", text: "Use standard text styles like .body or .headline")
                        bestPracticeRow(icon: "2.circle.fill", text: "Test with different accessibility sizes")
                        bestPracticeRow(icon: "3.circle.fill", text: "Ensure layouts adapt to text size changes")
                        bestPracticeRow(icon: "4.circle.fill", text: "Use scalable SF Symbols for icons")
                        bestPracticeRow(icon: "5.circle.fill", text: "Consider minimum touch targets (44×44 points)")
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Dynamic Type")
    }
    
    // Adaptive card that changes layout based on text size and device
    private var adaptiveCard: some View {
        // Determine if we should use vertical layout based on size category
        let useVerticalLayout = shouldUseVerticalLayout
        
        return Group {
            if useVerticalLayout {
                // Vertical layout for large text or compact devices
                VStack(alignment: .leading, spacing: 15) {
                    cardImage
                    cardContent
                }
            } else {
                // Horizontal layout for regular devices with smaller text
                HStack(spacing: 20) {
                    cardImage
                    cardContent
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    // Helper to determine layout based on size category and device
    private var shouldUseVerticalLayout: Bool {
        // Use vertical layout when text is large or on compact devices
        return horizontalSizeClass == .compact || 
               sizeCategory >= .extraLarge
    }
    
    private var cardImage: some View {
        Image(systemName: "text.viewfinder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .foregroundColor(.blue)
            .accessibilityHidden(true)
    }
    
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dynamic Layout Card")
                .font(.headline)
            
            Text("This card automatically switches between horizontal and vertical layouts based on text size and device")
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func bestPracticeRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .accessibilityHidden(true)
            
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(text)
    }
}

// Helper for displaying the size category name
extension ContentSizeCategory {
    var description: String {
        switch self {
        case .extraSmall: return "Extra Small"
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large (Default)"
        case .extraLarge: return "Extra Large"
        case .extraExtraLarge: return "Extra Extra Large"
        case .extraExtraExtraLarge: return "Extra Extra Extra Large"
        case .accessibilityMedium: return "Accessibility Medium"
        case .accessibilityLarge: return "Accessibility Large"
        case .accessibilityExtraLarge: return "Accessibility Extra Large"
        case .accessibilityExtraExtraLarge: return "Accessibility Extra Extra Large"
        case .accessibilityExtraExtraExtraLarge: return "Accessibility Extra Extra Extra Large"
        @unknown default: return "Unknown"
        }
    }
}

struct DynamicTypeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DynamicTypeView()
            }
            .environment(\.sizeCategory, .large)
            .previewDevice("iPhone 13")
            .previewDisplayName("iPhone (Default)")
            
            NavigationView {
                DynamicTypeView()
            }
            .environment(\.sizeCategory, .accessibilityLarge)
            .previewDevice("iPhone 13")
            .previewDisplayName("iPhone (Large Text)")
            
            NavigationView {
                DynamicTypeView()
            }
            .environment(\.sizeCategory, .large)
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewDisplayName("iPad")
        }
    }
}
