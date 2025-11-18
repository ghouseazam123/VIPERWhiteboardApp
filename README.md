
## 📸 Screenshots

<p align="center" style="margin:0; padding:0;">
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 50 14"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.19.png"/>
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 49 04"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.33.png"/>
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 49 04"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.47.png"/>
</p>

# 🧠 VIPER Whiteboard App

An interactive **Whiteboard App** built with **SwiftUI** following the **VIPER architecture**.
It allows drawing, erasing, color selection, saving strokes, navigation to a reference image, and much more.

---

## 🚀 Features Overview

* ✅ Draw on a canvas using Pencil
* ✅ Erase strokes with Eraser tool
* ✅ Pick colors with adjustable opacity
* ✅ Move toolbar anywhere on the screen
* ✅ Undo & Redo last strokes
* ✅ Save and load drawings using `UserDefaults`
* ✅ Delete drawings with confirmation alert
* ✅ Navigate to a **Reference Drawing** screen
* ✅ Proper error handling with `NetworkManager`
* ✅ Presenter-based color binding (no direct bindings)

---

## 🏗️ Architecture – VIPER Pattern

| Layer          | Responsibility                                                                             |
| -------------- | ------------------------------------------------------------------------------------------ |
| **View**       | SwiftUI UI components – handles gestures and user interface.                               |
| **Presenter**  | Business logic, tool handling, state updates, and communication between View & Interactor. |
| **Interactor** | Manages saving/loading strokes and network-related tasks.                                  |
| **Router**     | Handles navigation (e.g., to Reference Drawing screen).                                    |

---

## 🧩 Phases of Development

### 🏗️ Phase 1 – Basic Whiteboard Setup

**Goal:** Create a canvas for drawing using touch gestures.

* Added `WhiteboardView` with gesture-based drawing.
* Implemented `Stroke` model with points, color, and width.
* Presenter updates strokes using `@Published`.
  **Result:** Freehand drawing works smoothly.

### ✏️ Phase 2 – Tools and Color Picker

**Goal:** Add tools and color options.

* Added **movable toolbar** with Pencil, Eraser, Color Picker, and Clear.
* Eraser draws white strokes.
* Integrated SwiftUI `ColorPicker` with opacity.
  **Result:** Interactive toolbar with full drawing customization.

### 💾 Phase 3 – Save & Restore Strokes

**Goal:** Persist user drawings.

* Strokes saved in `UserDefaults` using JSON encoding.
* Added Load and Clear operations.
  **Result:** Drawings remain after relaunch.

### 🧭 Phase 4 – Navigation, Undo/Redo, Alerts

**Goal:** Make app more user-friendly.

* Implemented Undo/Redo via Presenter stacks.
* Navigation to Reference Image screen using Router.
* Alerts for confirming deletion.
* Better binding flow (Presenter owns color).
  **Result:** Clean UX and safe data management.

---

## 📸 Screenshots

<p align="center" style="margin:0; padding:0;">
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 50 14"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.19.png"/>
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 49 04"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.33.png"/>
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 49 04"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.47.png"/>
</p>

---

## ⚙️ Working Summary

* **Drawing:** Tracks finger movement and plots lines using SwiftUI `Path`.
* **Undo/Redo:** Two stacks for removed/added strokes.
* **Persistence:** JSON-encoded strokes in `UserDefaults`.
* **Navigation:** Router returns views cleanly, keeping VIPER structure.
* **Networking:** `NetworkManager` fetches reference images with error handling.

---

## 🔮 Future Enhancements

* Export whiteboard as PNG/JPEG
* Add zoom & pan gestures
* Infinite canvas or multi-page whiteboards
* Cloud sync using Firebase or iCloud
* Real-time collaboration using WebSockets

---

## 🧑‍💻 Technologies Used

* **SwiftUI** – Declarative and reactive UI
* **Combine** – Publishes changes to UI
* **VIPER** – Scalable and testable architecture
* **UserDefaults** – Lightweight storage
* **NetworkManager** – Modular networking layer

---

## 📚 Summary

This project evolved from a simple drawing area into a feature-rich **VIPER-structured Whiteboard App** showcasing:

* Clean architecture
* Real-world UIKit/SwiftUI integration
* Maintainable business logic separation
* Smooth drawing tools with persistence

Perfect for learning **VIPER**, **SwiftUI**, and **modular architecture** in real projects.

---
