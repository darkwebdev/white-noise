# White Noise iOS App

A minimal iOS app that plays multiple types of noise with a radio-button style interface.

## Features

- 10 different noise types: White, Pink, Brown, Blue, Soothing, Sea Waves, Heartbeat, Cafe, Rain, Beach
- Radio button interface (only one sound plays at a time, tap again to stop)
- Procedurally generated audio for most sounds (no audio files needed)
- Pastel color palette for both light and dark themes
- Sound wave dividers between sections
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

**Use iPhone 16 Pro simulator** - this is the preferred simulator for this project.

#### For Simulator:
```bash
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' clean build

xcrun simctl install "iPhone 16 Pro" \
  ~/Library/Developer/Xcode/DerivedData/WhiteNoise-*/Build/Products/Debug-iphonesimulator/WhiteNoise.app

xcrun simctl launch "iPhone 16 Pro" com.tmanyanov.whitenoise
```

#### For Physical Device:
```bash
# Build with code signing
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -sdk iphoneos \
  -configuration Debug -derivedDataPath build clean build

# Remove Watch app (causes installation issues)
rm -rf build/Build/Products/Debug-iphoneos/WhiteNoise.app/Watch

# Install to device (replace device ID with your device's ID)
xcrun devicectl device install app --device YOUR_DEVICE_ID \
  build/Build/Products/Debug-iphoneos/WhiteNoise.app
```

**Important:** For accurate audio testing, use a physical iOS device. The simulator's audio playback differs from real devices.

## File Structure

```
WhiteNoise/
├── Audio/
│   ├── WhiteNoiseEngine.swift          # Core audio generation (10 noise types)
│   └── AudioSessionManager.swift       # Audio session configuration
├── Views/
│   ├── ContentView.swift               # Main UI with 3 sections (2-column grid)
│   └── Components/
│       └── PlayPauseButton.swift       # NoiseTypeButton and SoundWaveDivider
├── WhiteNoiseApp.swift                 # App entry point
└── Info.plist                          # Background audio capability
```

## How It Works

### Audio Generation
- **Generated Sounds** (White, Pink, Brown, Blue, Soothing, Sea Waves, Heartbeat):
  - Uses `AVAudioEngine` with `AVAudioSourceNode` for real-time synthesis
  - Pink noise: Voss algorithm with 7 recursive filters
  - Brown noise: Random walk algorithm
  - Soothing: High-pass filtered white noise (85% feedback coefficient)
  - Sea Waves: 7-second wave period with envelope shaping
  - Heartbeat: 65 BPM with dual frequency modulation (80Hz/120Hz)

- **Sample-based Sounds** (Cafe, Rain, Beach):
  - Uses `AVAudioPlayerNode` with looping buffers
  - Currently marked as "In Development"
  - Placeholder audio generated until real samples are added

### UI Design
- **Layout**: 3 sections in 2-column grids
  1. Colored Noises: White, Pink, Brown, Blue
  2. Generated Sounds: Soothing, Sea Waves, Heartbeat
  3. Sample Sounds: Cafe, Rain, Beach (in development)
- **Styling**: Pastel colors with different palettes for light/dark mode
- **Dividers**: Canvas-based sound wave separators between sections
- **Buttons**: Transparent background with borders, show pause icon when active

### Background Playback
- Audio session configured with `.playback` category
- Info.plist includes `audio` background mode
- Continues playing when app is backgrounded or screen is locked

### State Management
- `WhiteNoiseEngine` is an `ObservableObject` with `@Published` properties
- Radio button behavior: Only one sound plays at a time
- Second tap on active button stops playback

## Testing Checklist

- [ ] App launches without crashes
- [ ] All 7 working noise types play correctly
- [ ] Only one noise plays at a time (radio button behavior)
- [ ] Second tap stops the currently playing sound
- [ ] Button shows pause icon when active
- [ ] Audio continues when app is backgrounded
- [ ] Audio continues when screen is locked
- [ ] Volume buttons control audio volume
- [ ] Works in both light and dark mode
- [ ] "In Development" label visible above sample sounds section
- [ ] Sound wave dividers render properly

## Troubleshooting

**No audio plays:**
- Check that audio session is configured (see console logs)
- Verify device volume is not muted
- Test on physical device, not simulator

**Audio stops in background:**
- Verify Info.plist has background audio mode enabled
- Check audio session category is `.playback`

**Build fails for device with Swift compiler timeout:**
- This happens with complex Canvas expressions when building for iphoneos SDK
- Solution: Extract complex expressions into separate functions
- Already fixed in `SoundWaveDivider` by using `generateWavePath(size:)` helper

**Watch app installation fails:**
- Bundle ID mismatch or WKWatchKitApp key issues
- Solution: Remove Watch app from built bundle before installing:
  ```bash
  rm -rf build/Build/Products/Debug-iphoneos/WhiteNoise.app/Watch
  ```

**Sample sounds (Cafe, Rain, Beach) don't work:**
- These are marked "In Development"
- Currently using placeholder audio generation
- Will be replaced with real audio files in future update

## Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- Swift 5.5 or later

## Attributions

- **Pacifier Icon** by Creative Studio from [Noun Project](https://thenounproject.com/browse/icons/term/pacifier/) (CC BY 3.0)

## License

Free to use and modify.
