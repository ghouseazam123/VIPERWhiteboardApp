# 🧠 VIPER Whiteboard App

I created this project using the **VIPER architecture** and built it in different **phases**.  
It started as a simple whiteboard that allows drawing with a pencil and eraser, then I added color selection, saving strokes using **UserDefaults**, and finally made the toolbar movable and interactive.

---

## 🏗️ Phase 1 – Basic Whiteboard Setup

### 🎯 Goal  
Create a simple **Whiteboard** that allows drawing on the screen with touch gestures.

### ⚙️ Working
- Added a `WhiteboardView` built using **SwiftUI** with a gesture-based drawing canvas.  
- Created a `Stroke` model containing a list of points, color, and line width.  
- Each touch movement updates the current stroke and renders lines in real-time.  
- Used **Combine** (`@Published`) to update the view whenever a new stroke is added.

### 🧩 VIPER Flow (Whiteboard)
- **WhiteboardView** – Displays the canvas and handles drawing gestures.  
- **WhiteboardPresenter** – Manages drawing logic (start, continue, end stroke).  
- **WhiteboardInteractor** – Handles saving and loading strokes using `UserDefaults`.  
- **WhiteboardRouter** – Handles navigation between modules (if extended).  

✅ **Result:**  
User can draw freely on a white canvas using the pencil tool.

---

## ✏️ Phase 2 – Tools and Color Selection

### 🎯 Goal  
Add multiple drawing tools (**Pencil**, **Eraser**) and a **Color Picker**.

### ⚙️ Working
- Added a `MovableToolbar` with buttons for **Pencil**, **Eraser**, **Color Picker**, and **Clear Canvas**.  
- Pencil allows colored drawing; eraser draws in white to simulate erasing.  
- `ColorPicker` dynamically updates the selected color via Presenter.  
- The toolbar can be **dragged anywhere** on the screen using `DragGesture`.

### 🧩 VIPER Flow (Toolbar)
- **MovableToolbar** – Provides UI for tool selection.  
- **WhiteboardPresenter** – Updates selected tool, color, and manages line width.  

✅ **Result:**  
User can change colors, erase strokes, clear the entire board, and move the toolbar.

---

## 💾 Phase 3 – Save and Restore Strokes (Persistence)

### 🎯 Goal  
Allow saving the user’s drawings so that they persist after app relaunch.

### ⚙️ Working
- Integrated **UserDefaults** in `WhiteboardInteractor` using JSON encoding.  
- On app start, all saved strokes are automatically loaded.  
- Added a **Save button** on the toolbar that triggers `saveStrokes()` in Interactor.  
- Clear button removes all strokes from both UI and storage.

### 🧩 VIPER Flow (Persistence)
- **WhiteboardInteractor**
  - `saveStrokes()` – Encodes all stroke data and saves to `UserDefaults`.  
  - `loadSavedStrokes()` – Decodes data when app opens.  
  - `clearAllStrokes()` – Deletes data from `UserDefaults`.

✅ **Result:**  
All drawings remain available even after app restarts.  
User can manually save or clear the canvas anytime.

---

## ⚙️ Architecture Overview

| Layer | Responsibility |
|--------|----------------|
| **View** | SwiftUI UI components – handles gestures and user interface. |
| **Presenter** | Business logic and communication between View & Interactor. |
| **Interactor** | Data handling, storage, and persistence logic. |
| **Router** | Navigation logic between screens (extendable). |

---

## 📸 Screenshots

<p align="center" style="margin:0; padding:0;">
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 50 14"
       src="VIPERWhiteboardApp/Screenshots/Simulator Screen Shot - iPhone 14 Pro - 2025-11-12 at 13.12.19.png"/>
  <img width="250" height="500" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-10 at 13 49 04"
       src="https://github.com/user-attachments/assets/ec638393-0c77-4581-9cf9-4a6f312b5007"/>
</p>


---

## 🧩 Features Summary

✅ Draw on canvas using Pencil  
✅ Erase strokes with Eraser tool  
✅ Pick custom colors  
✅ Move toolbar anywhere  
✅ Save and load strokes from `UserDefaults`  
✅ Clear the entire canvas  

---

## 🚀 Future Enhancements

- Export drawings as an image (PNG/JPEG)  
- Add undo/redo functionality  
- Enable multi-page whiteboards  
- Add cloud sync option for persistence  

---


