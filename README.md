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


project_root/
│
├── flutter_app/ # Flutter mobile app
│ ├── lib/
│ ├── android/
│ ├── ios/
│ └── pubspec.yaml
│
└── webpage/ # Angular internal tools dashboard
├── src/
├── angular.json
└── package.json


---

## 🎯 How Integration Works

| Platform | URL Used by Flutter |
|---------|---------------------|
| Android Emulator | `http://10.0.2.2:4200` |
| iOS Simulator | `http://localhost:4200` |
| Physical Devices | `http://<Local_Network_IP>:4200` |

Flutter loads the Angular dashboard via WebView based on the detected platform.

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

---

If you'd like a version with screenshots, badges, or a project logo, I can generate it too!
