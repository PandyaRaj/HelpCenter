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
Verify:
bash
Copy code
flutter doctor
node --version
npm --version
ng version
1️⃣ Start the Angular Dashboard
This must be running before Flutter loads the dashboard tab.

bash
Copy code
cd webpage
npm install
ng serve --host 0.0.0.0
URLs:
Browser: http://localhost:4200

Flutter (Android Emulator): http://10.0.2.2:4200

Flutter (iOS Simulator): http://localhost:4200

Physical Device: http://<your_IP>:4200

Keep this terminal running.

2️⃣ Start the Flutter App
bash
Copy code
cd flutter_app
flutter pub get
flutter run
Choose a device if needed:

bash
Copy code
flutter devices
flutter run -d <device_id>
3️⃣ Test Core Messaging Features
Try:

Send text messages

Use the emoji picker

Receive auto-replies

Switch tabs to see unread badge

Restart app to test persistence

Test dark mode

4️⃣ Test the Dashboard
Inside the Flutter app:

Open the Dashboard tab

Angular dashboard should load inside WebView

If not running → friendly error screen appears

❗ Troubleshooting
Flutter build fails?
bash
Copy code
flutter clean
flutter pub get
flutter run
Dashboard not loading in Flutter?
Ensure Angular server is running

Use correct URL based on device type

For physical devices, use local network IP

cpp
Copy code
http://192.168.x.x:4200
No devices detected?
bash
Copy code
flutter devices