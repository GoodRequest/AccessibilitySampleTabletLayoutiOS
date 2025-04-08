import SwiftUI

struct ContentView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            if horizontalSizeClass == .compact {
                // iPhone layout - vertical stacking
                CompactLayoutView()
            } else {
                // iPad layout - side-by-side content
                RegularLayoutView()
            }
        }
    }
}

struct CompactLayoutView: View {
    var body: some View {
        List {
            NavigationLink(destination: DynamicScalingView()) {
                FeatureRow(title: "Dynamic Scaling", 
                           description: "Demonstrates GeometryReader for responsive layouts",
                           systemImage: "arrow.up.left.and.arrow.down.right")
            }
            
            NavigationLink(destination: AccessibilityDemoView()) {
                FeatureRow(title: "Accessibility Features", 
                           description: "Examples of accessibility modifiers",
                           systemImage: "accessibility")
            }
            
            NavigationLink(destination: GridLayoutView()) {
                FeatureRow(title: "Adaptive Grid", 
                           description: "Grid layouts that adapt to screen size",
                           systemImage: "square.grid.2x2")
            }
            
            NavigationLink(destination: DynamicTypeView()) {
                FeatureRow(title: "Dynamic Type", 
                           description: "Text that scales with user preferences",
                           systemImage: "textformat.size")
            }
        }
        .navigationTitle("SwiftUI Adaptive Layout")
    }
}

struct RegularLayoutView: View {
    
    @State private var selectedDemo: String? = "dynamic"
    
    var body: some View {
        List(selection: $selectedDemo) {
            NavigationLink(destination: DynamicScalingView(), tag: "dynamic", selection: $selectedDemo) {
                FeatureRow(title: "Dynamic Scaling", 
                           description: "Demonstrates GeometryReader for responsive layouts",
                           systemImage: "arrow.up.left.and.arrow.down.right")
            }
            
            NavigationLink(destination: AccessibilityDemoView(), tag: "accessibility", selection: $selectedDemo) {
                FeatureRow(title: "Accessibility Features", 
                           description: "Examples of accessibility modifiers",
                           systemImage: "accessibility")
            }
            
            NavigationLink(destination: GridLayoutView(), tag: "grid", selection: $selectedDemo) {
                FeatureRow(title: "Adaptive Grid", 
                           description: "Grid layouts that adapt to screen size",
                           systemImage: "square.grid.2x2")
            }
            
            NavigationLink(destination: DynamicTypeView(), tag: "dynamictype", selection: $selectedDemo) {
                FeatureRow(title: "Dynamic Type", 
                           description: "Text that scales with user preferences",
                           systemImage: "textformat.size")
            }

            NavigationLink(destination: SettingsListView(), tag: "settingsList", selection: $selectedDemo) {
                FeatureRow(title: "Settings Demo",
                           description: "List Demo",
                           systemImage: "textformat.size")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("SwiftUI Adaptive Layout")
        .onAppear {
            if selectedDemo == nil {
                selectedDemo = "dynamic" // Auto-select first item on iPad
            }
        }
    }
}

struct FeatureRow: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 32)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(description)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13")
                .previewDisplayName("iPhone 13")
            
            ContentView()
                .previewDevice("iPad Pro (11-inch) (3rd generation)")
                .previewDisplayName("iPad Pro 11")
        }
    }
}
