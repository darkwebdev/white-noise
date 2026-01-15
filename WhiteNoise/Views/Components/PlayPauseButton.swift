import SwiftUI

struct SoundWaveDivider: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var randomSeed = Double.random(in: 0...1000)

    private func generateWavePath(size: CGSize) -> Path {
        let waveHeight: CGFloat = 10
        let midY = size.height / 2
        let envelopeFreq: CGFloat = 2.0
        let baseFreq: CGFloat = 80.0
        let seed = CGFloat(randomSeed)

        var path = Path()
        path.move(to: CGPoint(x: 0, y: midY))

        for x in stride(from: CGFloat(0), through: size.width, by: 2) {
            let relativeX = x / size.width

            let envelopePart = sin(relativeX * envelopeFreq * CGFloat.pi * 2 + seed)
            let envelope = envelopePart * 0.4 + 0.6

            let wave1 = sin(relativeX * baseFreq * CGFloat.pi * 2 + seed)
            let wave2Part = sin(relativeX * baseFreq * CGFloat.pi * 2 * 2.1 + seed * 1.3)
            let wave2 = wave2Part * 0.3
            let wave3Part = sin(relativeX * baseFreq * CGFloat.pi * 2 * 3.7 + seed * 0.7)
            let wave3 = wave3Part * 0.15

            let combinedWave = (wave1 + wave2 + wave3) * envelope
            let y = midY + combinedWave * (waveHeight / 2)

            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }

    var body: some View {
        Canvas { context, size in
            let path = generateWavePath(size: size)

            let waveColor: Color
            if colorScheme == .dark {
                waveColor = Color.pastelSkyDark.opacity(0.25)
            } else {
                waveColor = Color.pastelLavender.opacity(0.3)
            }

            let strokeStyle = StrokeStyle(lineWidth: 1.2, lineCap: .round, lineJoin: .round)
            context.stroke(path, with: .color(waveColor), style: strokeStyle)
        }
        .frame(height: 20)
        .padding(.horizontal, 12)
    }
}

extension Color {
    // Pastel colors for light mode
    static let pastelLavender = Color(red: 0.82, green: 0.76, blue: 0.90)
    static let pastelMint = Color(red: 0.72, green: 0.89, blue: 0.82)
    static let pastelPeach = Color(red: 0.98, green: 0.85, blue: 0.78)
    static let pastelSky = Color(red: 0.68, green: 0.85, blue: 0.90)

    // Pastel colors for dark mode
    static let pastelLavenderDark = Color(red: 0.55, green: 0.47, blue: 0.65)
    static let pastelMintDark = Color(red: 0.45, green: 0.62, blue: 0.55)
    static let pastelPeachDark = Color(red: 0.70, green: 0.55, blue: 0.48)
    static let pastelSkyDark = Color(red: 0.42, green: 0.58, blue: 0.63)

    static func pastelForPlaying(colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? pastelLavenderDark : pastelLavender
    }

    static func pastelForInactive(colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? pastelSkyDark.opacity(0.15) : pastelSky.opacity(0.2)
    }
}

struct NoiseTypeButton: View {
    let noiseType: NoiseType
    let isPlaying: Bool
    let action: () -> Void

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: isPlaying ? "pause.fill" : noiseType.icon)
                    .font(.system(size: 16))
                    .foregroundColor(isPlaying ? .white : (colorScheme == .dark ? .pastelMintDark : .pastelLavender))
                    .frame(width: 22)

                Text(noiseType.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(isPlaying ? .white : .primary)
                    .lineLimit(1)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isPlaying ? Color.pastelForPlaying(colorScheme: colorScheme) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isPlaying ? Color.clear : (colorScheme == .dark ? Color.pastelSkyDark.opacity(0.4) : Color.pastelLavender.opacity(0.5)),
                        lineWidth: 1.5
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
