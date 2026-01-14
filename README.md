# White Noise iOS App

A minimal iOS app that plays/pauses white noise with a single button.

## Features

- Simple play/pause button interface
- Procedurally generated white noise (no audio files needed)
- Background audio playback support
- Works when screen is locked or app is backgrounded

## Project Setup

### 1. Create Xcode Project

1. Open Xcode
2. Select **File > New > Project**
3. Choose **iOS > App**
4. Configure project:
   - **Product Name:** WhiteNoise
   - **Interface:** SwiftUI
   - **Language:** Swift
   - **Bundle Identifier:** com.yourname.whitenoise (change as needed)
   - **Minimum Deployments:** iOS 15.0 or later
5. Save to `/Users/tmanyanov/build/white-noise/`

### 2. Add Source Files to Xcode

After creating the project, add the implemented files:

1. In Xcode, right-click on the **WhiteNoise** folder in the Project Navigator
2. Select **Add Files to "WhiteNoise"...**
3. Navigate to `/Users/tmanyanov/build/white-noise/WhiteNoise/`
4. Select all the source files and folders:
   - `Audio/` folder (with WhiteNoiseEngine.swift and AudioSessionManager.swift)
   - `Views/` folder (with ContentView.swift and Components/PlayPauseButton.swift)
   - `WhiteNoiseApp.swift`
5. Make sure **"Copy items if needed"** is checked
6. Click **Add**

### 3. Configure Info.plist for Background Audio

1. In Xcode Project Navigator, select the project (top-level "WhiteNoise")
2. Select the **WhiteNoise** target
3. Go to the **Info** tab
4. Find **Custom iOS Target Properties**
5. Add a new row:
   - **Key:** Required background modes
   - **Type:** Array
   - Click the disclosure triangle and add item:
     - **Item 0:** App plays audio or streams audio/video using AirPlay

Alternatively, replace the auto-generated Info.plist with the one provided at `WhiteNoise/Info.plist`.

### 4. Build and Run

1. Select a simulator (iPhone 15 Pro recommended) or connect a physical device
2. Press **Cmd+R** to build and run
3. The app will launch with a centered play/pause button
4. Tap the button to start/stop white noise

**Important:** For accurate audio testing, use a physical iOS device. The simulator's audio playback differs from real devices.

## File Structure

```
WhiteNoise/
├── Audio/
│   ├── WhiteNoiseEngine.swift          # Core audio generation using AVAudioEngine
│   └── AudioSessionManager.swift       # Audio session configuration
├── Views/
│   ├── ContentView.swift              # Main UI with play/pause button
│   └── Components/
│       └── PlayPauseButton.swift      # Reusable button component
├── WhiteNoiseApp.swift                 # App entry point
└── Info.plist                          # Background audio capability
```

## How It Works

### Audio Generation
- Uses `AVAudioEngine` with `AVAudioSourceNode` to generate white noise in real-time
- Produces random Float samples between -1.0 and 1.0 at 44.1kHz
- Volume reduced to 30% of max amplitude to prevent harshness
- No audio files needed - procedurally generated

### Background Playback
- Audio session configured with `.playback` category
- Info.plist includes `audio` background mode
- Continues playing when app is backgrounded or screen is locked

### State Management
- `WhiteNoiseEngine` is an `ObservableObject` with `@Published var isPlaying`
- UI automatically updates when state changes
- SwiftUI bindings connect button to audio engine

## Testing Checklist

- [ ] App launches without crashes
- [ ] Tap play button → white noise starts
- [ ] Tap pause button → white noise stops
- [ ] Button icon changes (play ↔ pause)
- [ ] Audio continues when app is backgrounded
- [ ] Audio continues when screen is locked
- [ ] Volume buttons control white noise volume
- [ ] Works in both light and dark mode

## Troubleshooting

**No audio plays:**
- Check that audio session is configured (see console logs)
- Verify device volume is not muted
- Test on physical device, not simulator

**Audio stops in background:**
- Verify Info.plist has background audio mode enabled
- Check audio session category is `.playback`

**Audio is too harsh:**
- Reduce volume multiplier in WhiteNoiseEngine.swift (line 31)
- Change `* 0.3` to `* 0.2` or lower

## Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- Swift 5.5 or later

## License

Free to use and modify.
