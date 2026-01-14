import SwiftUI

struct WatchContentView: View {
    @StateObject private var audioEngine = WhiteNoiseEngine()

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack {
                Spacer()

                PlayPauseButton(isPlaying: $audioEngine.isPlaying) {
                    if audioEngine.isPlaying {
                        audioEngine.pause()
                    } else {
                        audioEngine.play()
                    }
                }

                Spacer()
            }
        }
        .onAppear {
            audioEngine.setupAudioGraph()
        }
    }
}

#Preview {
    WatchContentView()
}
