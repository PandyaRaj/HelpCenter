# Quick Start Guide

A short guide to running both the Flutter mobile app and the Angular dashboard.

---

## ✔ Prerequisites

### Install:
- Flutter SDK 3.x  
- Node.js 16+  
- npm 8+  
- Angular CLI  

```bash
npm install -g @angular/cli
```

### Verify installations:
```bash
flutter doctor
node --version
npm --version
ng version
```

---

# 1️⃣ Start the Angular Dashboard

This must be running *before* Flutter loads the dashboard tab.

```bash
cd webpage
npm install
ng serve --host 0.0.0.0
```

### URLs:
- Browser → `http://localhost:4200`
- Flutter (Android Emulator) → `http://10.0.2.2:4200`
- Flutter (iOS Simulator) → `http://localhost:4200`
- Physical Device → `http://<your_IP>:4200`

> Keep this terminal open while the Flutter app is running.

---

# 2️⃣ Start the Flutter App

```bash
cd flutter_app
flutter pub get
flutter run
```

Choose a specific device if needed:

```bash
flutter devices
flutter run -d <device_id>
```

---

## 🔧 Optional: Generate local build files

Some Flutter plugins (including Hive) generate supporting `.g.dart` files.  
If you see any missing adapter errors, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

# 3️⃣ Test Core Messaging Features

Try:
- Send text messages  
- Use the emoji picker  
- Receive auto-replies  
- Switch tabs to see unread badge  
- Restart app to verify persistence  
- Enable dark mode  

---

# 4️⃣ Test the Dashboard

Inside the Flutter app:
- Open the **Dashboard** tab  
- Angular dashboard should load inside WebView  
- If Angular isn’t running → a friendly error message appears  

---

# ❗ Troubleshooting

### Flutter build fails?
```bash
flutter clean
flutter pub get
flutter run
```

### Dashboard not loading in Flutter?
- Ensure Angular server is running  
- Use correct URL based on device type  
- For physical devices, use your machine's LAN IP:

```
http://192.168.x.x:4200
```

### No devices detected?
```bash
flutter devices
```

---

# 🎉 You're ready!

You now have both the mobile messaging app and the embedded Angular dashboard running together.
