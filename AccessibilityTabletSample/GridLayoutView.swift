import SwiftUI

struct GridLayoutView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // Sample data for grid items
    private let items = (1...16).map { MyGridItem(id: $0, color: Color(hue: Double($0) / 20, saturation: 0.8, brightness: 0.9)) }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Adaptive Grid Layouts")
                    .font(.largeTitle)
                    .padding()
                
                // Example 1: LazyVGrid that adapts based on size class
                VStack(alignment: .leading) {
                    Text("LazyVGrid with Adaptive Columns")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Determine number of columns based on size class
                    let columns = [
                        GridItem(.adaptive(minimum: horizontalSizeClass == .compact ? 80 : 120), spacing: 16)
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(items) { item in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(item.color)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Text("\(item.id)")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                )
                                .accessibilityLabel("Grid item \(item.id)")
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Example 2: Fixed column grid with different configurations for iPad vs iPhone
                VStack(alignment: .leading) {
                    Text("Size Class Specific Grid")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Different column setup based on size class
                    let columnsForSizeClass: [GridItem] = horizontalSizeClass == .compact
                        ? [GridItem(.flexible()), GridItem(.flexible())] // 2 columns for iPhone
                        : [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // 3 columns for iPad
                    
                    LazyVGrid(columns: columnsForSizeClass, spacing: 16) {
                        ForEach(items.prefix(6)) { item in
                            VStack {
                                Circle()
                                    .fill(item.color)
                                    .frame(height: horizontalSizeClass == .compact ? 60 : 100)
                                    .accessibilityHidden(true)
                                
                                Text("Item \(item.id)")
                                    .font(.subheadline)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Circle item \(item.id)")
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)
                
                // Example 3: Horizontal Grid
                VStack(alignment: .leading) {
                    Text("LazyHGrid for Horizontal Scrolling")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Different row heights based on device
                    let rowHeight: CGFloat = horizontalSizeClass == .compact ? 100 : 150
                    let rows = [
                        GridItem(.fixed(rowHeight))
                    ]
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 16) {
                            ForEach(items) { item in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(item.color)
                                    .frame(width: rowHeight) // Square cells
                                    .overlay(
                                        Text("\(item.id)")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .accessibilityLabel("Horizontal scrolling grid with \(items.count) items")
                    .accessibilityHint("Swipe left or right to scroll through items")
                }
                .padding(.top, 20)
                
                // Device info
                VStack(alignment: .leading) {
                    Text("Device Information")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Size Class: \(horizontalSizeClass == .compact ? "Compact" : "Regular")")
                            Text("Device Type: \(horizontalSizeClass == .compact ? "iPhone" : "iPad")")
                            Text("Grid Adapts: Automatically adjusts columns and spacing")
                        }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                    .padding(.horizontal)
                }
                .padding(.top, 20)
            }
            .padding(.bottom)
        }
        .navigationTitle("Adaptive Grids")
    }
}

// Model for grid items
struct MyGridItem: Identifiable {
    let id: Int
    let color: Color
}

struct GridLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                GridLayoutView()
            }
            .previewDevice("iPhone 13")
            .previewDisplayName("iPhone 13")
            
            NavigationView {
                GridLayoutView()
            }
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .previewDisplayName("iPad Pro 11")
        }
    }
}
