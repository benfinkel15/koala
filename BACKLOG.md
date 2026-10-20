# Koala — Feature Backlog

Tasks are ordered by priority. Pick the first uncompleted task, implement it fully, mark it ✅, commit, and push.

---

## In Progress
_(none)_

---

## To Do

### 1. Vocabulary Bank tab
- Add a 3rd tab to the bottom nav (between Learn and Profile): "Vocab" with a book icon
- Create `lib/features/vocab/presentation/vocab_screen.dart`
- The screen shows vocabulary grouped by lesson, but only lessons the user has completed
- For now, "completed" means the lesson exists in a hardcoded set: ['u1_l1', 'u1_l2'] (we'll wire real progress later)
- Extract vocab from `lib/content/german/vocab_bank.dart` — create this new file with vocab for all 15 lessons
- Each vocab entry: German word, English translation, gender (der/die/das/— for phrases), part of speech
- UI: searchable list, grouped by unit with expandable sections, each word shows German + English + gender chip
- Tapping a word shows a detail card with example sentence from the lesson

### 2. Conversation Practice tab
- Add a 4th tab: "Chat" with a chat bubble icon
- Create `lib/features/conversation/presentation/conversation_screen.dart`
- On first open, show a scenario picker: "Café", "Meeting someone", "At the market", "Free chat"
- Each scenario sets a system prompt for the AI: e.g. for "Café", the AI plays a German waiter
- Use the Claude API directly via HTTP (package:http is already a transitive dep — add it explicitly to pubspec.yaml)
- API endpoint: POST https://api.anthropic.com/v1/messages
- Required headers: `x-api-key`, `anthropic-version: 2023-06-01`, `content-type: application/json`
- Model: claude-haiku-4-5-20251001 (fast and cheap for conversation)
- The API key is stored in SharedPreferences under key `anthropic_api_key`
- On first open (if no key stored), show a dialog asking user to enter their Anthropic API key
- The AI always responds in German, then provides an English translation in italics below
- The AI gently corrects grammar mistakes inline: if the user writes "Ich bin hungrig haben" the AI responds naturally but also notes the correction
- Message bubbles: user on right (green), AI on left (grey)
- Add a settings icon in the AppBar to clear/change the API key

### 3. AI content generation for new languages
- Add a language selector to the home screen AppBar (currently hardcoded to German)
- Languages to support: German (already done), Spanish, French, Italian, Japanese
- When a new language is selected and no curriculum exists for it yet, show a "Generating curriculum..." loading screen
- Call Claude API (claude-sonnet-4-6) to generate a curriculum in the same format as `lib/content/german/curriculum.dart`
- The prompt should specify: same 3-unit structure, same exercise types, same conversation-first philosophy
- Cache the generated curriculum in Hive so it only generates once per language
- Store under Hive box `'curriculum'`, key `'<language_code>'` (e.g. 'es', 'fr')
- Create `lib/services/curriculum_generator.dart` for this logic

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
_(none yet)_
