import SwiftUI

struct PlayPauseButton: View {
    @Binding var isPlaying: Bool
    let action: () -> Void

    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(
                            width: min(geometry.size.width, geometry.size.height) * 0.6,
                            height: min(geometry.size.width, geometry.size.height) * 0.6
                        )

                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.25))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(.plain)
        }
    }
}
