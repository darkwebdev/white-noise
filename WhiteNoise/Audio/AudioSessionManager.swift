import AVFoundation
import MediaPlayer

class AudioSessionManager {
    static let shared = AudioSessionManager()

    private init() {}

    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)

            // Enable remote control events
            UIApplication.shared.beginReceivingRemoteControlEvents()
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }
}
