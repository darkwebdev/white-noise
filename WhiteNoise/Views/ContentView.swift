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
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Title
                HStack(spacing: 8) {
                    Image("pacifier")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.pastelLavender)
                    Text("Pacifier")
                        .font(.system(size: 24, weight: .semibold))
                }
                .padding(.top, 20)
                .padding(.bottom, 16)

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
                .padding(.top, 20)

                SoundWaveDivider()
                    .padding(.vertical, 20)

                // Generated Sounds Section
                HStack {
                    Text("In Development")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                    Spacer()
                }
                .padding(.bottom, 12)

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
                    .padding(.vertical, 20)

                // Sample Sounds Section
                HStack {
                    Text("Planned")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                    Spacer()
                }
                .padding(.bottom, 12)

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
                .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            audioEngine.setupAudioGraph()
        }
    }
}

#Preview {
    ContentView()
}
