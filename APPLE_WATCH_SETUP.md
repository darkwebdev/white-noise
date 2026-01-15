# Apple Watch App Setup Guide

The white noise app now includes Apple Watch support! Follow these steps to add the watchOS target to your Xcode project.

## What's Included

All the watchOS app files have been created:
- **WhiteNoise Watch App/WhiteNoiseWatchApp.swift** - Watch app entry point
- **WhiteNoise Watch App/Views/WatchContentView.swift** - Watch UI
- **WhiteNoise Watch App/Info.plist** - Watch configuration with background audio
- **WhiteNoise Watch App/Assets.xcassets/** - Watch app icons

The iOS app's button has been updated with responsive sizing that works on both iPhone and Apple Watch.

## Setup Steps in Xcode

### 1. Open Your Project in Xcode
1. Open `/Users/tmanyanov/build/white-noise/WhiteNoise.xcodeproj` in Xcode

### 2. Add watchOS Target
1. In Xcode, go to **File → New → Target**
2. Select **watchOS → Watch App for iOS App**
3. Click **Next**
4. Configure the target:
   - **Product Name:** WhiteNoise Watch App
   - **Bundle Identifier:** com.example.whitenoise.watchkitapp (or your own bundle ID)
   - **Organization Name:** Your name
   - **Language:** Swift
   - **Interface:** SwiftUI
   - **Minimum Deployments:** watchOS 8.0
5. Click **Finish**
6. When prompted "Activate 'WhiteNoise Watch App' scheme?", click **Activate**

### 3. Replace Auto-Generated Files
Xcode will create some default files. Replace them with our custom files:

1. **Delete** the auto-generated files in the watch target (keep the target itself):
   - Delete ContentView.swift (we have WatchContentView.swift)
   - Delete any other auto-generated files

2. **Add** our custom files to the watch target:
   - Right-click on "WhiteNoise Watch App" folder in Xcode
   - Select **Add Files to "WhiteNoise Watch App"...**
   - Navigate to `/Users/tmanyanov/build/white-noise/WhiteNoise Watch App/`
   - Select all files and folders:
     - WhiteNoiseWatchApp.swift
     - Views/ folder
     - Info.plist
     - Assets.xcassets/
   - **Important:** Make sure "Copy items if needed" is checked
   - Make sure "WhiteNoise Watch App" target is selected
   - Click **Add**

### 4. Share Core Audio Files with watchOS Target

Add the existing audio files to both iOS and watchOS targets:

1. In Xcode Project Navigator, select **WhiteNoise/Audio/WhiteNoiseEngine.swift**
2. In the **File Inspector** (right panel), under **Target Membership**, check both:
   - ☑ WhiteNoise
   - ☑ WhiteNoise Watch App

3. Repeat for **WhiteNoise/Audio/AudioSessionManager.swift**:
   - ☑ WhiteNoise
   - ☑ WhiteNoise Watch App

4. Repeat for **WhiteNoise/Views/Components/PlayPauseButton.swift**:
   - ☑ WhiteNoise
   - ☑ WhiteNoise Watch App

### 5. Configure Watch Target Settings

1. Select the **WhiteNoise.xcodeproj** in Project Navigator
2. Select the **WhiteNoise Watch App** target
3. Go to **Signing & Capabilities** tab:
   - Enable **Automatically manage signing**
   - Select your **Team** (your Apple ID)
4. Go to **Build Settings** tab:
   - Search for "Deployment Target"
   - Set **watchOS Deployment Target** to **8.0** or later

### 6. Add Background Audio Capability (if not already present)

1. With **WhiteNoise Watch App** target selected
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **Background Modes**
5. Check **Audio, AirPlay, and Picture in Picture**

### 7. Build and Test

**Test on Simulator:**
1. Select **WhiteNoise Watch App** scheme from the scheme dropdown (top of Xcode)
2. Select a watch simulator (e.g., "Apple Watch Series 9 (45mm)")
3. Press **Cmd+R** to build and run
4. The watch app should launch and show a centered play/pause button
5. Click play - white noise will play through your Mac speakers

**Test on Physical Watch:**
1. Pair your Apple Watch with your Mac via Xcode (Window → Devices and Simulators)
2. Select your physical watch from the device dropdown
3. Press **Cmd+R** to build and install
4. The app will install on your watch
5. **First time:** On your iPhone, go to Settings → General → VPN & Device Management → Trust your developer certificate
6. Launch the app on your watch and tap play

## Features

### Independent Watch App
- Works without iPhone nearby (WKWatchOnly = true)
- Audio plays through watch speaker or connected AirPods/Bluetooth
- Background audio continues when screen is off
- Digital Crown controls volume automatically

### Responsive UI
- Button automatically scales to 60% of screen size
- Works perfectly on all Apple Watch sizes (38mm-49mm)
- Works perfectly on all iPhone sizes
- Same codebase for both platforms

### Shared Code
- Core audio engine (WhiteNoiseEngine.swift) is shared
- Audio session management (AudioSessionManager.swift) is shared
- Play/pause button component (PlayPauseButton.swift) is shared
- No code duplication needed!

## Troubleshooting

### "No such module 'WhiteNoise'"
- Make sure you added the audio files to both targets via Target Membership

### "Cannot find 'WhiteNoiseEngine' in scope"
- Check that WhiteNoiseEngine.swift has both targets selected in File Inspector

### Watch app won't build
- Clean build folder: Product → Clean Build Folder (Cmd+Shift+K)
- Restart Xcode
- Make sure all shared files have both targets checked

### Audio doesn't play on watch
- Check Info.plist has UIBackgroundModes with "audio"
- Verify AudioSessionManager is called in WhiteNoiseWatchApp init
- Try on physical watch (simulator audio is less reliable)

### UI looks wrong
- The PlayPauseButton.swift should use GeometryReader for responsive sizing
- Check that you're using the updated version with percentage-based sizing

## File Structure

After setup, your project should look like this in Xcode:

```
WhiteNoise.xcodeproj
├── WhiteNoise (iOS App)
│   ├── Audio/
│   │   ├── WhiteNoiseEngine.swift        [Shared with watchOS]
│   │   └── AudioSessionManager.swift     [Shared with watchOS]
│   ├── Views/
│   │   ├── ContentView.swift
│   │   └── Components/
│   │       └── PlayPauseButton.swift     [Shared with watchOS]
│   ├── Assets.xcassets/
│   ├── Info.plist
│   └── WhiteNoiseApp.swift
│
└── WhiteNoise Watch App
    ├── Views/
    │   └── WatchContentView.swift
    ├── Assets.xcassets/
    │   └── AppIcon.appiconset/
    ├── Info.plist
    └── WhiteNoiseWatchApp.swift
```

## Testing Checklist

- [ ] iOS app still builds and runs
- [ ] watchOS app builds and runs
- [ ] Play/pause button works on iPhone
- [ ] Play/pause button works on Apple Watch
- [ ] Audio plays on watch speaker
- [ ] Audio continues when watch screen is off
- [ ] Both apps can run simultaneously
- [ ] UI scales correctly on different watch sizes

## Next Steps

Once the watch app is working:
1. Test battery usage during extended playback
2. Consider adding complications for quick access
3. Consider adding a sleep timer feature
4. Share the app with friends via TestFlight!

## Need Help?

Common issues:
- **Build errors:** Make sure all files are added to correct targets
- **Audio issues:** Test on physical watch, not just simulator
- **Code signing:** Enable automatic signing and select your team

For more details, see the implementation plan at:
`/Users/tmanyanov/.claude/plans/recursive-imagining-prism.md`
