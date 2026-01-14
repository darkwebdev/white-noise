import SwiftUI

struct WatchContentView: View {
    @StateObject private var audioEngine = WhiteNoiseEngine()

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Text("Noise Type")
                    .font(.headline)
                    .padding(.top, 8)

                ForEach(NoiseType.allCases, id: \.self) { noiseType in
                    NoiseTypeButton(
                        noiseType: noiseType,
                        isPlaying: audioEngine.isPlaying && audioEngine.currentNoiseType == noiseType
                    ) {
                        audioEngine.setNoiseType(noiseType)
                    }
                }
                .padding(.horizontal, 8)
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
