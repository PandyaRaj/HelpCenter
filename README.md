# Messaging App + Internal Tools Dashboard

A full-stack project combining a **Flutter mobile messaging app** with an **Angular-based internal tools dashboard**, embedded inside the app using WebView. The project demonstrates a clean UI, local data persistence, responsive design, and seamless mobile–web integration.

---

## 🚀 Features

### 📱 Flutter Messaging App
- Modern chat interface with message bubbles  
- Text and emoji messaging  
- Auto-reply simulation  
- Local message storage using Hive  
- Unread message badge  
- Smart timestamps (Today, Yesterday)  
- Dark mode support  
- Smooth UI animations  
- Dashboard tab loading Angular app via WebView  

### 🌐 Angular Internal Tools Dashboard
- Runs on `localhost:4200`  
- Ticket viewer with filtering  
- Knowledge base Markdown editor with live preview  
- Real-time logs panel with auto-scroll and pause/resume  
- Tailwind CSS responsive layout  
- Fully functional inside Flutter WebView  

---

## 🏗️ Tech Stack

### Flutter (Mobile)
- Flutter 3.x  
- Dart (null-safe)  
- Hive (local DB)  
- webview_flutter plugin  

### Angular (Web)
- Angular 16+  
- Tailwind CSS  
- TypeScript  

---

## 📁 Project Structure

```text
project_root/
│
├── flutter_app/               # Flutter mobile app
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
│
└── webpage/                   # Angular internal tools dashboard
    ├── src/
    ├── angular.json
    └── package.json
```

---

## 🔧 Running the Project Locally

This project includes a Flutter mobile app and an Angular dashboard.  
Follow these steps to run both parts together.

---

### 1. Start the Angular Dashboard

```bash
cd webpage
npm install
ng serve --host 0.0.0.0
```

The dashboard will be available at:

- Browser: `http://localhost:4200`
- Flutter Android Emulator: `http://10.0.2.2:4200`
- Flutter iOS Simulator: `http://localhost:4200`

Leave this running.

---

### 2. Start the Flutter App

Open another terminal:

```bash
cd flutter_app
flutter pub get
flutter run
```

To list connected devices:

```bash
flutter devices
```

If needed:

```bash
flutter run -d <device_id>
```

---

### (Optional) If you see Hive adapter errors

Some generated files may need to be rebuilt:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🧩 Key Capabilities

- Real-time simulated chat  
- Smooth animations and transitions  
- Persistent message history  
- Multi-screen navigation  
- Platform-aware WebView connection  
- Responsive Angular interface  
- Markdown editing, preview, and tools  
- Filtering, logging, and simulation modules  

---

## 🧭 Roadmap / Future Enhancements

- Push notifications  
- Backend live messaging  
- User authentication  
- Cloud-synced dashboard data  
- Deployable Angular build with hosting  

---

## 📄 License
MIT License (or choose your own)
