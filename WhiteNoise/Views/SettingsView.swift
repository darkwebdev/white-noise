import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("appTheme") private var appTheme: String = AppTheme.auto.rawValue
    @Environment(\.colorScheme) var colorScheme

    var selectedTheme: AppTheme {
        AppTheme(rawValue: appTheme) ?? .auto
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Appearance")) {
                    ForEach(AppTheme.allCases, id: \.self) { theme in
                        Button(action: {
                            appTheme = theme.rawValue
                        }) {
                            HStack {
                                Image(systemName: theme.icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(colorScheme == .dark ? .pastelMintDark : .pastelLavender)
                                    .frame(width: 24)

                                Text(theme.rawValue)
                                    .foregroundColor(.primary)

                                Spacer()

                                if selectedTheme == theme {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(colorScheme == .dark ? .pastelMintDark : .pastelLavender)
                                }
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }

                Section(header: Text("About")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pacifier")
                            .font(.headline)

                        Text("A soothing white noise app for babies and adults")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                Section(header: Text("Attributions")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pacifier Icon")
                            .font(.subheadline)
                            .fontWeight(.medium)

                        Text("by Creative Studio from Noun Project (CC BY 3.0)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    SettingsView()
}
