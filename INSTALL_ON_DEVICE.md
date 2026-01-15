# Installing White Noise App on Your iPhone

## Prerequisites

1. **Connect your iPhone** to your Mac via USB cable
2. **Unlock your iPhone** and tap "Trust This Computer" when prompted
3. **Apple ID** for code signing (free, no developer account required)

## Option 1: Install via Xcode (Recommended - GUI)

### Step 1: Open the Project in Xcode
1. Open **Xcode**
2. Go to **File > Open**
3. Navigate to `/Users/tmanyanov/build/white-noise/`
4. Select **WhiteNoise.xcodeproj** and click **Open**

### Step 2: Add Your Apple ID (First Time Only)
1. In Xcode, go to **Xcode > Settings** (or press `Cmd + ,`)
2. Click the **Accounts** tab
3. Click the **+** button in the bottom left
4. Select **Apple ID** and click **Continue**
5. Sign in with your Apple ID and password
6. Close the Settings window

### Step 3: Configure Signing
1. In Xcode's Project Navigator (left sidebar), click on **WhiteNoise** (the blue project icon at the top)
2. Select the **WhiteNoise** target in the middle panel
3. Click the **Signing & Capabilities** tab
4. Check **Automatically manage signing**
5. Under **Team**, select your Apple ID (it will show as "Your Name (Personal Team)")
6. The **Bundle Identifier** may change to include your team ID - this is normal

### Step 4: Select Your iPhone
1. At the top of Xcode, next to the Play/Stop buttons, you'll see a device dropdown
2. Click it and select your iPhone from the list (it should show "Timmeh" or your iPhone name)
3. If your iPhone doesn't appear, make sure it's connected and unlocked

### Step 5: Build and Run
1. Click the **Play** button (▶) at the top left of Xcode, or press `Cmd + R`
2. Xcode will build the app and install it on your iPhone
3. **First time only**: You'll see an error about an untrusted developer

### Step 6: Trust Your Developer Certificate (First Time Only)
1. On your iPhone, go to **Settings**
2. Go to **General > VPN & Device Management**
3. Under "Developer App", tap on your Apple ID email
4. Tap **Trust "[Your Apple ID]"**
5. Tap **Trust** in the popup

### Step 7: Run the App
1. Go back to Xcode and press the **Play** button again
2. The app will launch on your iPhone!

---

## Option 2: Install via Command Line (Advanced)

If your iPhone is connected and you've already added your Apple ID to Xcode, I can build and install it for you via command line.

### Requirements:
- iPhone connected and unlocked
- Apple ID added to Xcode (see Option 1, Step 2)
- Device trusted on your iPhone

### Commands:
```bash
# Find your device ID
xcrun xctrace list devices

# Build and install (replace DEVICE_ID with your iPhone's ID)
xcodebuild -project WhiteNoise.xcodeproj \
  -scheme WhiteNoise \
  -configuration Debug \
  -destination 'id=DEVICE_ID' \
  -allowProvisioningUpdates

# The app will be installed on your device
```

---

## Troubleshooting

### "No profiles for 'com.example.whitenoise' were found"
- Make sure you've added your Apple ID to Xcode (see Step 2)
- Enable "Automatically manage signing" in Signing & Capabilities

### "The device is locked"
- Unlock your iPhone and try again

### "Untrusted Developer"
- Follow Step 6 to trust your developer certificate on your iPhone

### "Unable to install"
- Disconnect and reconnect your iPhone
- Restart Xcode
- Make sure your iPhone is running iOS 15.0 or later

### "Revoke Certificate" warning
- This is normal if you're using a free Apple ID
- Click "Revoke Certificate" and try again
- You can only have 2 certificates active at a time with a free account

---

## Free vs Paid Apple Developer Account

### Free (Personal Team):
- ✅ Can install apps on your own devices
- ✅ Test on up to 3 devices
- ✅ Apps expire after 7 days (need to rebuild/reinstall)
- ❌ Cannot distribute to others
- ❌ Cannot publish to App Store

### Paid ($99/year):
- ✅ Apps don't expire
- ✅ Can distribute to testers via TestFlight
- ✅ Can publish to App Store
- ✅ Advanced capabilities (push notifications, iCloud, etc.)

For personal use, the **free option is perfectly fine** for this white noise app!

---

## Quick Start (After Initial Setup)

Once you've set up code signing:

1. Connect iPhone
2. Open project in Xcode
3. Select your iPhone from device dropdown
4. Press Play (Cmd+R)

The app will build and install in about 10-15 seconds!
