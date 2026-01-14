import AVFoundation

class AudioSessionManager {
    static let shared = AudioSessionManager()

    private init() {}

    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }
}
