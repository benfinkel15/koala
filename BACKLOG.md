# Koala — Feature Backlog

Tasks are ordered by priority. Pick the first uncompleted task, implement it fully, mark it ✅, commit, and push.

---

## In Progress
_(none)_

---

## To Do

### 4. Lesson progress tracking
- Track which lessons the user has completed and their star rating (1–3 stars based on mistakes)
- Store in Hive box `'progress'`, key `'<lessonId>'`, value: `{'stars': int, 'xp': int, 'completedAt': ISO string}`
- On lesson complete: write to Hive, update the home screen lesson nodes to show stars
- The vocab bank (task 1) should read from this same Hive box to filter shown vocab
- XP total: sum all xp values from the progress box, display on profile screen

### 5. Streak system
- Track daily practice in Hive box `'streak'`
- Fields: `currentDays`, `longestDays`, `lastCompletedDate` (ISO date string, local timezone)
- After any lesson is completed: check if today's date != lastCompletedDate, if so increment streak
- If more than 1 day has passed since lastCompletedDate: reset streak to 1
- Show live streak count in home screen AppBar (currently hardcoded to 3)
- Show streak history on profile screen

### 6. Spaced repetition review screen
- Add "Review" tab between Learn and Vocab
- Pull vocab items from completed lessons (same source as vocab bank)
- Show items due for review based on a simple SM-2-like schedule stored in Hive
- Exercise format: show German word, user types English (or vice versa)
- After answering, update the item's next review date

### 7. Onboarding flow
- Show on first launch only (check Hive key `'onboardingComplete'`)
- 3 screens: Welcome → Daily goal picker (Casual/Regular/Serious) → Language picker
- After completing: set `onboardingComplete: true`, navigate to home
- Store daily goal in Hive: `'dailyGoalXp'` → 10/20/30 for Casual/Regular/Serious

### 8. Firebase Auth
- Wire up the existing Firebase packages (firebase_core, firebase_auth are in pubspec.yaml)
- Requires a real Firebase project — add a note in code: "TODO: add google-services.json / GoogleService-Info.plist"
- For now implement email/password auth screens (login + register)
- Gate the app behind auth: show login screen if no user, home screen if logged in
- Sync Hive progress data to Firestore on login

---

## Completed

### ✅ 3. AI content generation for new languages
- Added language selector to home screen AppBar (German, Spanish, French, Italian, Japanese)
- Created `lib/services/curriculum_generator.dart` with `CurriculumService` singleton
- Calls Claude API (claude-sonnet-4-6) to generate curricula for non-German languages
- Shows "Generating curriculum…" loading screen while generating
- Caches generated curricula in Hive box `'curriculum'`, key `'<language_code>'`
- Lesson screen uses active curriculum via `CurriculumService` with German fallback
- Initializes Hive in `main.dart`; selected language persisted in SharedPreferences

### ✅ 2. Conversation Practice tab
- Added Chat tab (4th tab) with chat bubble icon to bottom nav
- Created `lib/features/conversation/presentation/conversation_screen.dart`
- Scenario picker: "Café", "Meeting someone", "At the market", "Free chat"
- Each scenario sets a German-speaking system prompt for the AI
- Uses Claude API (claude-haiku-4-5-20251001) via HTTP with explicit `http` package dependency
- API key stored/retrieved from SharedPreferences under `anthropic_api_key`
- API key dialog shown on first open; settings icon in AppBar to change key
- AI responds in German with English translation in italics below
- AI gently corrects grammar mistakes inline
- Message bubbles: user on right (green), AI on left (grey)

### ✅ 1. Vocabulary Bank tab
- Added a 3rd tab to the bottom nav (between Learn and Profile): "Vocab" with a book icon
- Created `lib/features/vocab/presentation/vocab_screen.dart`
- Created `lib/content/german/vocab_bank.dart` with vocab for all 15 lessons (5–7 entries each)
- Each vocab entry: German word, English translation, gender (der/die/das/— for phrases), part of speech, example sentence
- UI: searchable list, grouped by unit with expandable sections, each word shows German + English + gender chip
- Tapping a word shows a detail dialog with example sentence from the lesson

### ✅ 2. GitHub Pages deployment
- Created `.github/workflows/deploy.yml` — on every push to main, builds Flutter web and deploys to `gh-pages` branch
- Added live URL note to README.md
