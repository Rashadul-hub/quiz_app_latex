# quiz_app_latex

A Flutter quiz app with LaTeX support for math and science questions, featuring a local leaderboard using Hive.Theme can be toggled between light and dark mode from the HomeScreen AppBar
--
## Features
- Render math/science questions using LaTeX
- Local leaderboard with Hive
- Timer for quiz questions
- Offline support
- Responsive Material 3 UI
- Theme toggle (light/dark mode)
---

---
## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Rashadul-hub/quiz_app_latex.git
cd quiz_app_latex
```
### 2. Install Dependencies
```bash
flutter pub get
```
### 3. Generate Hive Adapters
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
### 4. Run the app
```bash
flutter run
```
  For build apk : ```bash flutter build apk --release```

## Architecture
- State Management: Provider
- Local Storage: Hive
- UI: Material 3
- LaTeX Rendering: flutter_math_fork & latext
- Code Structure: MVVM approach for clean code separation
--
## Notes
- Ensure Flutter SDK >= 3.4.0 and < 4.0.0
- Use flutter pub run build_runner build --delete-conflicting-outputs after modifying Hive models
- Supports offline usage with local Hive storage
- Timer automatically pauses when leaving the quiz screen
- LaTeX questions are rendered with flutter_math_fork for full math/science formatting.
--
## Project Structure 
```bash
lib/
├── main.dart
|── models/
│   ├── leaderboard_entry.dart
│   └── leaderboard_entry.g.dart
│   └── questions.dart
├── providers/
│   ├── quiz_provider.dart
│   └── theme_provider.dart
├── services/
│   └── local_store.dart
├── views/
│   ├── home_screen.dart
│   ├── quiz_screen.dart
│   ├── results_screen.dart
│   └── leaderboard_screen.dart
├── widgets/
│   ├── latex_text.dart
│   └── option_tile.dart
assets/
├── images/
└── questions.json
```
 
 
