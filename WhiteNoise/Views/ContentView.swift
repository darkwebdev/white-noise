import SwiftUI

struct ContentView: View {
    @StateObject private var audioEngine = WhiteNoiseEngine()
    @State private var showSettings = false
    @AppStorage("appTheme") private var appTheme: String = AppTheme.auto.rawValue
    @Environment(\.colorScheme) var systemColorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var settingsViewID = UUID()

    let coloredNoises: [NoiseType] = [.white, .pink, .brown, .blue]
    let generatedSounds: [NoiseType] = [.shushRhythmic, .seaWaves, .cafe, .rain, .beach]
    let sampleSounds: [NoiseType] = []

    var columns: [GridItem] {
        // Balanced columns: 2 in portrait, 3 in landscape for even distribution
        let columnCount = horizontalSizeClass == .regular ? 3 : 2
        return Array(repeating: GridItem(.flexible(minimum: 160, maximum: 200), spacing: 12), count: columnCount)
    }

    var preferredColorScheme: ColorScheme? {
        guard let theme = AppTheme(rawValue: appTheme) else { return nil }
        switch theme {
        case .light: return .light
        case .dark: return .dark
        case .auto: return nil
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Top spacer
                    Spacer()

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
                    }
                    .padding(.horizontal, max(geometry.safeAreaInsets.leading, 16))

                    // Middle spacer
                    Spacer()

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
                    .padding(.horizontal, max(geometry.safeAreaInsets.leading, 12))

                    SoundWaveDivider()
                        .padding(.vertical, 20)
                        .padding(.horizontal, max(geometry.safeAreaInsets.leading, 12))

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
                    .padding(.horizontal, max(geometry.safeAreaInsets.leading, 12))

                    // Bottom spacer
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .preferredColorScheme(preferredColorScheme)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .id(settingsViewID)
                .preferredColorScheme(preferredColorScheme ?? systemColorScheme)
        }
        .onAppear {
            audioEngine.setupAudioGraph()
        }
        .onChange(of: appTheme) { _ in
            settingsViewID = UUID()
        }
    }
}

#Preview {
    ContentView()
}
