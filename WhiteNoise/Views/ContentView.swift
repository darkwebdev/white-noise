import SwiftUI

struct ContentView: View {
    @StateObject private var audioEngine = WhiteNoiseEngine()
    @State private var showSettings = false
    @AppStorage("appTheme") private var appTheme: String = AppTheme.auto.rawValue
    @Environment(\.colorScheme) var systemColorScheme

    let coloredNoises: [NoiseType] = [.white, .pink, .brown, .blue]
    let generatedSounds: [NoiseType] = [.shush, .seaWaves, .heartbeat]
    let sampleSounds: [NoiseType] = [.cafe, .rain, .beach]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var preferredColorScheme: ColorScheme? {
        guard let theme = AppTheme(rawValue: appTheme) else { return nil }
        switch theme {
        case .light: return .light
        case .dark: return .dark
        case .auto: return nil
        }
    }

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Title and Settings
                HStack {
                    Spacer()

                    HStack(alignment: .center, spacing: 8) {
                        Image("pacifier")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(systemColorScheme == .dark ? .pastelMintDark : .pastelLavender)
                            .offset(y: 2)
                        Text("Pacifier")
                            .font(.system(size: 24, weight: .semibold))
                    }

                    Spacer()

                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 20))
                            .foregroundColor(systemColorScheme == .dark ? .pastelMintDark : .pastelLavender)
                    }
                    .padding(.trailing, 16)
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
        .preferredColorScheme(preferredColorScheme)
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .preferredColorScheme(preferredColorScheme)
                .id(appTheme)
        }
        .onAppear {
            audioEngine.setupAudioGraph()
        }
    }
}

#Preview {
    ContentView()
}
