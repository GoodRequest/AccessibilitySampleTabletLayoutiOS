import SwiftUI

struct SettingsListView: View {
    // Sample settings data
    private let generalSettings = [
        SettingsItem(title: "About", icon: "info.circle", iconColor: .gray),
        SettingsItem(title: "Software Update", icon: "arrow.triangle.2.circlepath", iconColor: .red, badge: "1"),
        SettingsItem(title: "AirDrop", icon: "arrow.down.to.line", iconColor: .blue),
        SettingsItem(title: "Storage", icon: "externaldrive", iconColor: .blue)
    ]
    
    private let appearanceSettings = [
        SettingsItem(title: "Display & Brightness", icon: "sun.max", iconColor: .blue),
        SettingsItem(title: "Home Screen", icon: "apps.iphone", iconColor: .blue),
        SettingsItem(title: "Accessibility", icon: "accessibility", iconColor: .blue),
        SettingsItem(title: "Wallpaper", icon: "photo", iconColor: .blue)
    ]
    
    private let appsSettings = [
        SettingsItem(title: "App Store", icon: "square.stack.3d.up", iconColor: .blue),
        SettingsItem(title: "Maps", icon: "map", iconColor: .green),
        SettingsItem(title: "Safari", icon: "safari", iconColor: .blue),
        SettingsItem(title: "News", icon: "newspaper", iconColor: .red),
        SettingsItem(title: "Translate", icon: "character.bubble", iconColor: .blue),
        SettingsItem(title: "Health", icon: "heart", iconColor: .red),
        SettingsItem(title: "Photos", icon: "photo.on.rectangle", iconColor: .blue)
    ]
    
    private let accountSettings = [
        SettingsItem(title: "Apple ID", icon: "person.crop.circle", iconColor: .gray, showDisclosure: true),
        SettingsItem(title: "Password & Security", icon: "lock", iconColor: .gray),
        SettingsItem(title: "iCloud", icon: "cloud", iconColor: .blue),
        SettingsItem(title: "Media & Purchases", icon: "bag", iconColor: .red)
    ]
    
    var body: some View {
        List {
            SettingsProfileSection()
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Apple ID Profile")

            SettingsSectionGroup(title: "General", items: generalSettings)
            
            SettingsSectionGroup(title: "Appearance", items: appearanceSettings)
            
            SettingsSectionGroup(title: "Apps", items: appsSettings)
            
            SettingsSectionGroup(title: "Accounts", items: accountSettings)
            
            Section {
                Toggle(isOn: .constant(true)) {
                    HStack {
                        Image(systemName: "wifi")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                            .padding(.trailing, 8)
                        Text("Wi-Fi")
                            .font(.body)
                    }
                }
                .accessibilityHint("Toggle to enable or disable Wi-Fi")
                
                Toggle(isOn: .constant(false)) {
                    HStack {
                        Image(systemName: "airplane")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                            .padding(.trailing, 8)
                        Text("Airplane Mode")
                            .font(.body)
                    }
                }
                .accessibilityHint("Toggle to enable or disable Airplane Mode")
                
                HStack {
                    Image(systemName: "bluetooth")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                        .padding(.trailing, 8)
                    
                    Text("Bluetooth")
                        .font(.body)
                    
                    Spacer()
                    
                    Text("On")
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .accessibilityHint("Select to view Bluetooth settings")
            } header: {
                Text("Connectivity")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
    }
}

struct SettingsItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let iconColor: Color
    var badge: String? = nil
    var showDisclosure: Bool = false
}

struct SettingsSectionGroup: View {
    let title: String
    let items: [SettingsItem]
    
    var body: some View {
        Section(header: Text(title)) {
            ForEach(items) { item in
                HStack {
                    Image(systemName: item.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(item.iconColor)
                        .padding(.trailing, 8)
                    
                    Text(item.title)
                        .font(.body)
                    
                    Spacer()
                    
                    if let badge = item.badge {
                        Text(badge)
                            .font(.caption)
                            .padding(6)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .accessibilityLabel("\(badge) unread notifications")
                    }
                    
                    if item.showDisclosure {
                        Image(systemName: "chevron.right")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .contentShape(Rectangle())
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(item.title)")
                .accessibilityAddTraits(.isButton)
            }
        }
    }
}

struct SettingsProfileSection: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("John Appleseed")
                        .font(.headline)
                    Text("Apple ID, iCloud, Media & Purchases")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding(.vertical, 10)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsListView()
        }
    }
}
