import SwiftUI
import AVKit

struct AudioOutputPickerButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme

    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePicker = AVRoutePickerView()
        routePicker.prioritizesVideoDevices = false
        return routePicker
    }

    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        let tintColor = colorScheme == .dark ?
            UIColor(Color.pastelMintDark) : UIColor(Color.pastelLavender)
        uiView.activeTintColor = tintColor
        uiView.tintColor = tintColor
    }
}
