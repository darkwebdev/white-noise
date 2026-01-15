import Foundation

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case auto = "Auto"

    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .auto: return "circle.lefthalf.filled"
        }
    }
}
