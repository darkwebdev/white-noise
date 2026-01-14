import SwiftUI

@main
struct WhiteNoiseApp: App {
    init() {
        AudioSessionManager.shared.configureAudioSession()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
