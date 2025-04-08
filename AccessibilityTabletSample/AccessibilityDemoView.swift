import SwiftUI

struct AccessibilityDemoView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Accessibility Features")
                    .font(.largeTitle)
                    .padding()
                
                // Example 1: Combined Elements
                VStack {
                    Text("Combined Elements")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DemoCard {
                        VStack(spacing: 10) {
                            Text("Signup Form")
                                .font(.title3)
                            
                            Button("Create Account") {
                                // Action
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Signup Form with Create Account button")
                        .accessibilityHint("These elements are grouped together for easier navigation")
                    }
                }
                
                // Example 2: Custom Labels
                VStack {
                    Text("Custom Accessibility Labels")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DemoCard {
                        HStack(spacing: 20) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                                .accessibilityHidden(true) // Hide from accessibility as label covers it
                            
                            Toggle("", isOn: .constant(true))
                                .labelsHidden()
                                .accessibilityLabel("Notification settings")
                                .accessibilityHint("Toggle to enable or disable notifications")
                        }
                        .padding()
                    }
                }
                
                // Example 3: Accessibility Actions
                VStack {
                    Text("Custom Accessibility Actions")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DemoCard {
                        VStack {
                            Image(systemName: isExpanded ? "arrow.up.left.and.arrow.down.right" : "arrow.down.right.and.arrow.up.left")
                                .font(.system(size: 40))
                                .padding()
                            
                            Text(isExpanded ? "Content is expanded" : "Content is collapsed")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Expandable content")
                        .accessibilityHint("Double tap to expand or collapse")
                        .accessibilityAction {
                            isExpanded.toggle()
                        }
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                    }
                }
                
                // Example 4: Trait Adjustments
                VStack {
                    Text("Accessibility Traits")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DemoCard {
                        VStack(spacing: 15) {
                            Text("Current Status: Active")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(5)
                                .accessibilityAddTraits(.isStaticText)
                                .accessibilityLabel("Status: Active")
                            
                            Text("ERROR: Connection lost")
                                .foregroundColor(.red)
                                .accessibilityAddTraits(.isHeader)
                                .accessibilityLabel("Error message: Connection lost")
                        }
                        .padding()
                    }
                }
                
                // Example 5: iPad-specific adjustments
                VStack {
                    Text("Device-Specific Adjustments")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DemoCard {
                        if horizontalSizeClass == .regular {
                            // iPad layout - side by side
                            HStack(spacing: 20) {
                                Image(systemName: "ipad")
                                    .font(.system(size: 50))
                                
                                VStack(alignment: .leading) {
                                    Text("iPad Layout Detected")
                                        .font(.title3)
                                    Text("Showing optimized layout for larger screens")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("iPad optimized layout")
                        } else {
                            // iPhone layout - stacked
                            VStack(spacing: 15) {
                                Image(systemName: "iphone")
                                    .font(.system(size: 50))
                                
                                Text("iPhone Layout Detected")
                                    .font(.title3)
                                Text("Showing compact layout for smaller screens")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("iPhone optimized layout")
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Accessibility")
    }
}

struct DemoCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct AccessibilityDemoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AccessibilityDemoView()
            }
            .previewDevice("iPhone 13")
            .previewDisplayName("iPhone 13")
            
            NavigationView {
                AccessibilityDemoView()
            }
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewDisplayName("iPad Pro 11")
        }
    }
}
