import SwiftUI

struct ContentView: View {
    @StateObject private var audioEngine = WhiteNoiseEngine()

    let coloredNoises: [NoiseType] = [.white, .pink, .brown, .blue]
    let generatedSounds: [NoiseType] = [.shush, .seaWaves, .heartbeat]
    let sampleSounds: [NoiseType] = [.cafe, .rain, .beach]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Colored Noises Section
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(coloredNoises, id: \.self) { noiseType in
                        NoiseTypeButton(
                            noiseType: noiseType,
                            isPlaying: audioEngine.isPlaying && audioEngine.currentNoiseType == noiseType
                        ) {
                            audioEngine.setNoiseType(noiseType)
                        }
                    }
                }
                .padding(.horizontal, 12)

                SoundWaveDivider()

                // Generated Sounds Section
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(generatedSounds, id: \.self) { noiseType in
                        NoiseTypeButton(
                            noiseType: noiseType,
                            isPlaying: audioEngine.isPlaying && audioEngine.currentNoiseType == noiseType
                        ) {
                            audioEngine.setNoiseType(noiseType)
                        }
                    }
                }
                .padding(.horizontal, 12)

                SoundWaveDivider()

                // Sample Sounds Section
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(sampleSounds, id: \.self) { noiseType in
                        NoiseTypeButton(
                            noiseType: noiseType,
                            isPlaying: audioEngine.isPlaying && audioEngine.currentNoiseType == noiseType
                        ) {
                            audioEngine.setNoiseType(noiseType)
                        }
                    }
                }
                .padding(.horizontal, 12)

                Spacer(minLength: 20)
            }
        }
        .onAppear {
            audioEngine.setupAudioGraph()
        }
    }
}

#Preview {
    ContentView()
}
