# 🧠 VIPER Whiteboard App

An interactive **Whiteboard App** built with **SwiftUI** following the **VIPER architecture**.  
It allows drawing, erasing, color selection, saving strokes, navigation to a reference image, and much more.

---

## 🚀 Features Overview

✅ Draw on a canvas using Pencil  
✅ Erase strokes with Eraser tool  
✅ Pick colors with adjustable opacity  
✅ Move toolbar anywhere on the screen  
✅ Undo & Redo last strokes  
✅ Save and load drawings using `UserDefaults`  
✅ Delete drawings with confirmation alert  
✅ Navigate to a **Reference Drawing** screen  
✅ Proper error handling with `NetworkManager`  
✅ Presenter-based color binding (no direct bindings)

---

## 🏗️ Architecture – VIPER Pattern

| Layer | Responsibility |
|-------|----------------|
| **View** | SwiftUI UI components – handles gestures and user interface. |
| **Presenter** | Business logic, tool handling, and communication between View & Interactor. |
| **Interactor** | Manages saving/loading strokes and network-related tasks. |
| **Router** | Handles navigation (e.g., to Reference Drawing screen). |

---

## 🧩 Phases of Development

### 🏗️ Phase 1 – Basic Whiteboard Setup
**Goal:** Create a canvas for drawing using touch gestures.  
- Added `WhiteboardView` with gesture-based drawing.  
- `Stroke` model includes points, color, and line width.  
- `Presenter` handles real-time stroke updates using `@Published`.  
✅ **Result:** User can draw freely with the pencil tool.

---

### ✏️ Phase 2 – Tools and Color Picker
**Goal:** Add tools and color options.  
- Added a **movable toolbar** with Pencil, Eraser, Color Picker, and Clear options.  
- Eraser simulates white strokes.  
- Integrated **SwiftUI ColorPicker** (with opacity).  
✅ **Result:** User can select color and move the toolbar anywhere.

---

### 💾 Phase 3 – Save & Restore Strokes (Persistence)
**Goal:** Persist drawings between app sessions.  
- Used `UserDefaults` with JSON encoding for strokes.  
- Added Save and Clear functionality.  
✅ **Result:** Strokes remain saved after relaunch.

---

### 🧭 Phase 4 – Navigation, Undo/Redo, and Alerts
**Goal:** Add navigation and user-friendly interactions.  
- Implemented **Undo/Redo** via `Presenter`.  
- Added a **Reference button** (top-right) that navigates to a sample internet image.  
- Implemented **Alerts** for delete confirmation.  
- Improved **Binding** (Presenter now manages color, not direct binding).  
✅ **Result:** App now supports navigation, confirmation dialogs, and safer data flow.

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

- **Drawing:** Real-time line rendering using SwiftUI Paths.
- **Undo/Redo:** Managed through two stacks for previous/next strokes.
- **Persistence:** Strokes encoded to JSON and stored in `UserDefaults`.
- **Navigation:** Managed via `WhiteboardRouter` returning an `AnyView`.
- **Error Handling:** `NetworkManager` handles image fetch and displays errors gracefully.

---

## 🔮 Future Enhancements

- Export drawings as images (PNG/JPEG)  
- Add multi-page whiteboards  
- Add gesture-based zooming/panning  
- Implement cloud sync for collaborative drawing  

---

## 🧑‍💻 Technologies Used

- **SwiftUI** – Declarative UI  
- **Combine** – Reactive updates  
- **VIPER Architecture** – Modular and scalable design  
- **UserDefaults** – Local persistence  
- **NetworkManager** – Network abstraction and error handling  

---

### 📚 Summary

This project evolved from a **basic drawing canvas** into a **feature-rich, VIPER-structured whiteboard app** that showcases:
- Clean architectural separation  
- Real-world feature integration  
- Maintainable and testable SwiftUI code  

---


