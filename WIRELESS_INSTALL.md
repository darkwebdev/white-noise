# Wireless Installation Guide

You can install apps on your iPhone wirelessly over WiFi, but you need to set it up first.

## Setup (One-Time, Requires USB Cable)

### Step 1: Initial USB Connection
1. **Connect your iPhone to your Mac** via USB cable
2. **Unlock your iPhone** and tap "Trust This Computer"

### Step 2: Enable Network Debugging in Xcode
1. Open **Xcode**
2. Go to **Window > Devices and Simulators** (or press `Shift + Cmd + 2`)
3. Select your iPhone from the left sidebar (under "Devices")
4. Check the box **"Connect via network"**
5. Wait for the network icon (📶) to appear next to your device name
6. **Now you can disconnect the USB cable!**

### Step 3: Verify Wireless Connection
- Your iPhone should still appear in the Devices window with a network icon
- Both your Mac and iPhone must be on the **same WiFi network**

## Installing Apps Wirelessly (After Setup)

Once network debugging is enabled:

1. Open **Xcode**
2. Open the WhiteNoise project
3. Select your iPhone from the device dropdown (it will show the network icon 📶)
4. Press **Play** to build and install wirelessly
5. Done!

---

## Requirements for Wireless Installation

✅ **Same WiFi network**: Mac and iPhone must be on the same local network
✅ **Initial USB setup**: Must enable "Connect via network" once via USB
✅ **Xcode 9 or later**: Built-in wireless debugging support
✅ **iOS 11 or later**: Your iPhone needs iOS 11+ (you have iOS 15+, so you're good!)

---

## Alternative: Using Bluetooth (Not Recommended)

Bluetooth **cannot** be used to install apps. It's too slow and not supported by Xcode.

---

## Alternative: Installing via the Internet (Remote/Cloud)

If you want to install without being on the same network, you have a few options:

### Option 1: TestFlight (Best for Remote Installation)
**Requirements**: Paid Apple Developer account ($99/year)

1. Upload your app to App Store Connect
2. Invite yourself as a tester
3. Install TestFlight app on your iPhone
4. Download your app from TestFlight
5. **Advantage**: Works from anywhere in the world, app doesn't expire

### Option 2: Ad Hoc Distribution
**Requirements**: Paid Apple Developer account ($99/year)

1. Archive your app in Xcode
2. Export as Ad Hoc distribution
3. Upload the .ipa file to a service like Diawi.com or install via Apple Configurator
4. Install on your iPhone from the download link
5. **Advantage**: Direct installation, no App Store review

### Option 3: Enterprise Distribution
**Requirements**: Apple Enterprise Developer account ($299/year) + company

- For internal company apps only
- Not applicable for personal projects

---

## What I Recommend

### For Your Situation (Personal Use):

**Best approach:**
1. **First time**: Connect via USB, enable "Connect via network" in Xcode
2. **After that**: Install wirelessly over WiFi whenever Mac and iPhone are on same network
3. **Use free Apple ID**: No need to pay $99 unless you want to publish to App Store

**Limitations of free account:**
- Apps expire after 7 days (just rebuild and reinstall, takes 15 seconds)
- Must rebuild from Xcode (can't share with friends)
- Up to 3 devices at a time

**This is perfect for personal projects like this white noise app!**

---

## Quick Comparison

| Method | Cost | Setup | Range | App Expiry |
|--------|------|-------|-------|------------|
| **USB** | Free | None | Cable length | 7 days (free account) |
| **WiFi (local)** | Free | USB once | Same WiFi | 7 days (free account) |
| **TestFlight** | $99/year | Upload to App Store Connect | Anywhere (internet) | 90 days |
| **Ad Hoc** | $99/year | Export + upload | Anywhere (internet) | 1 year |

---

## Troubleshooting Wireless Connection

### "Device not found" after enabling network mode
- Make sure both Mac and iPhone are on the same WiFi network
- Restart Xcode
- Toggle "Connect via network" off and on again
- Reconnect via USB and try again

### Wireless installation is very slow
- This is normal - wireless is slower than USB
- First installation wirelessly can take 1-2 minutes
- Subsequent installs are faster

### Connection keeps dropping
- Make sure your WiFi is stable
- Try moving closer to your WiFi router
- Disable VPNs on Mac or iPhone
- Use USB instead if WiFi is unreliable

### "Unable to install, device locked"
- Unlock your iPhone
- Keep it unlocked during installation
- After installation completes, you can lock it again

---

## Current Status Check

To check if wireless debugging is already enabled:

```bash
# Check if your device supports network connection
xcrun xctrace list devices | grep -i "timmeh"
```

If you see your device without "(Offline)", it might be connectable!
