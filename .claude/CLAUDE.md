# WhiteNoise Project Instructions

## Build and Install Workflow

After each build, ALWAYS install the app on BOTH simulators and the physical iPhone device.

### Build Commands

```bash
# Build for simulator
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -configuration Release -sdk iphonesimulator -arch arm64 -derivedDataPath build/

# Build for physical device
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -configuration Release -sdk iphoneos -arch arm64 -derivedDataPath build/
```

### Installation Commands

**iPhone SE (3rd generation) Simulator:**
```bash
xcrun simctl install A2F1884B-8CD3-429D-A024-8B50FEA7F970 build/Build/Products/Release-iphonesimulator/WhiteNoise.app
xcrun simctl launch A2F1884B-8CD3-429D-A024-8B50FEA7F970 com.tmanyanov.whitenoise
```

**iPhone 16 Pro Simulator:**
```bash
xcrun simctl install 80176F55-8090-450F-B72A-D3D54CA92D99 build/Build/Products/Release-iphonesimulator/WhiteNoise.app
xcrun simctl launch 80176F55-8090-450F-B72A-D3D54CA92D99 com.tmanyanov.whitenoise
```

**Physical iPhone (Timmeh):**
```bash
xcrun devicectl device install app --device 00008110-00194C9E3480A01E build/Build/Products/Release-iphoneos/WhiteNoise.app
```

### Complete Workflow Example

```bash
# 1. Build for simulator
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -configuration Release -sdk iphonesimulator -arch arm64 -derivedDataPath build/

# 2. Install on both simulators
xcrun simctl install A2F1884B-8CD3-429D-A024-8B50FEA7F970 build/Build/Products/Release-iphonesimulator/WhiteNoise.app
xcrun simctl install 80176F55-8090-450F-B72A-D3D54CA92D99 build/Build/Products/Release-iphonesimulator/WhiteNoise.app

# 3. Build for physical device
xcodebuild -project WhiteNoise.xcodeproj -scheme WhiteNoise -configuration Release -sdk iphoneos -arch arm64 -derivedDataPath build/

# 4. Install on physical iPhone
xcrun devicectl device install app --device 00008110-00194C9E3480A01E build/Build/Products/Release-iphoneos/WhiteNoise.app
```

## Device Information

- **iPhone SE (3rd gen)**: iOS 17.2 (UUID: A2F1884B-8CD3-429D-A024-8B50FEA7F970)
- **iPhone 16 Pro**: iOS 18.6 (UUID: 80176F55-8090-450F-B72A-D3D54CA92D99)
- **Physical iPhone**: Timmeh (UUID: 00008110-00194C9E3480A01E)

## Important Notes

- Always test on both simulators to ensure consistency across iOS versions (17.2 and 18.6)
- The physical device requires code signing (automatic with default build)
- Clean builds: Use `rm -rf build/` before building if needed
