import SwiftUI

@main
struct WhiteNoiseWatchApp: App {
    init() {
        AudioSessionManager.shared.configureAudioSession()
    }

    var body: some Scene {
        WindowGroup {
            WatchContentView()
        }
    }
}
