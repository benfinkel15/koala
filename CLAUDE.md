# Koala — Language Learning App

Flutter + Firebase app that teaches languages through conversation-first lessons.
Goal: get users speaking as fast as possible by teaching real phrases first, then contextualizing grammar from those phrases.

## Stack
- Flutter 3.47 / Dart
- Firebase Auth + Firestore
- Riverpod (state management)
- go_router (navigation)
- Hive (local cache)

## Running the app
```bash
export PATH="$HOME/development/flutter/bin:$PATH"
flutter pub get
flutter run -d chrome --web-port 8080
```

## Project structure
```
lib/
  main.dart                          # App entry point
  core/
    constants/app_colors.dart        # Color palette
    router/app_router.dart           # go_router setup + MainScaffold (bottom nav)
  features/
    home/presentation/home_screen.dart      # Lesson path UI
    lesson/presentation/lesson_screen.dart  # Exercise runner (4 exercise types)
    profile/presentation/profile_screen.dart
  content/
    german/curriculum.dart           # All German lesson exercise data
```

## Exercise types (all implemented in lesson_screen.dart)
- `multipleChoice` — 4 options, one correct
- `tapToBuild` — tap word tiles to form a sentence
- `fillBlank` — type the missing word
- `conjugationTable` — fill all 6 verb forms

## How to add a new feature
1. Read BACKLOG.md — pick the top uncompleted task
2. Implement it following the existing patterns
3. Mark it as completed in BACKLOG.md with ✅
4. Commit with a descriptive message and push to main

## Commit style
Short imperative subject line, no period. Example:
`add vocabulary bank tab with completed-lesson filtering`

## Key design principles
- Conversation-first: every feature should help users speak sooner
- Don't add features not in BACKLOG.md
- Keep Dart files under 400 lines — split if needed
- No placeholder/TODO comments in committed code
