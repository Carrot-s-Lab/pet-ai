# Chat Feature — Product Requirements

## Overview

AI-powered chat experience for pet owners. The chat allows users to ask questions about their pet's health, behavior, diet, and care, with responses powered by the app's AI backend. The UI must feel smooth, premium, and friendly — consistent with the Catti design language.

---


## 1. Chat Home Screen (Main Screen)

### Header
- Display the **Pixel avatar** (the 3D orange tabby cat with caramel collar and silver name tag) on the left, cropped circular.
  - This is the app's AI mascot — a fixed asset, not the user's pet photo.
  - Asset: 3D render of an orange tabby, lavender background, caramel collar, silver circular tag engraved "PIXEL".
  - Displayed at ~44–48px diameter, circular crop, no border needed (the lavender background blends with the screen gradient).
- To the right of the avatar, two lines:
  - **Title:** `"[Pet name]'s Care Chat"` — e.g. *"Luna's Care Chat"*. Uses `AppFonts.h2` (Brand/Nunito, SemiBold).
  - **Subtitle:** basic pet data in a single line — `[Breed] · [Age] · [Weight]` — e.g. *"Persian · 4 years · 4.2 kg"*. Uses `AppFonts.captionM`, `AppColors.stone`.
- CTA to **create a new chat** ("+") in the top-right corner.
- Pet data (name, breed, age, weight) is pulled from the saved pet profile.

### Background
- Full-screen **gradient background** using the lavender palette:
  - `AppColors.lavenderWash` → `AppColors.lavenderLight` (top to bottom).
- This same gradient applies to the individual chat screen as well.

### Chat History List
- Displays all previous chat sessions as a scrollable list of **elevated cards**.
- Each card has:
  - Rounded corners (20px), white card surface (`AppColors.cardSurface`), warm shadow.
  - Cat icon or paw avatar on the left.
  - **Chat title** (`AppFonts.h4`) — first user message or auto-generated.
  - **Preview** of the last message (`AppFonts.bodyS`, single line, truncated with ellipsis).
  - **Date/time** of last message (`AppFonts.captionM`, `AppColors.stone`), right-aligned.

### Empty State
- Shown when no chats exist yet.
- Display a **grid of 2–3 quick-start suggestion cards** (e.g. "Check a symptom", "Ask about diet", "Behaviour question").
- Below the grid: a prominent **"Start a new chat"** `AppButton` (primary caramel style).
- No illustration required — the cards themselves serve as the visual anchor.

### Delete Chat (Swipe to Delete)
- Swiping a chat item **to the left** reveals a **delete action** (red destructive button).
- Confirm deletion with a dialog (`DialogFrame`) before permanently removing.

---

## 2. Chat Screen

### App Bar
- Shows the **chat title** (editable, defaults to first user message or "New Chat").
- Back button on the left (`AppBackButton`).

### Message Bubbles

| Role | Alignment | Background | Border |
|------|-----------|------------|--------|
| User | Right | Caramel gradient (`AppColors.caramel` → `AppColors.caramelDeep`) | None |
| AI   | Left  | White card (`AppColors.cardSurface`) | Left accent bar in `AppColors.lavender` |

- Text: `AppFonts.bodyM`.
- Bubble corner radius: 16px (user), 16px with flat top-left corner (AI).
- Timestamps shown below each bubble in `AppFonts.captionM` / `AppColors.stone`.
- Photo attachments appear as a **thumbnail inside the user bubble** (rounded corners, tappable to view full-size).

### AI Typing Indicator
- While the AI is generating a response, show a **running cat icon animation** in place of the AI bubble.
- Animation: the cat icon loops horizontally (running in place or sliding) using a Lottie or frame-by-frame sprite animation.
- Displayed inside a bubble shell matching the AI bubble style (white card, lavender left accent) so the transition to the real response feels seamless.

### Quick Tasks Row
- Horizontal-scroll chip row **pinned above the input bar**.
- Chips are tappable and pre-fill the input with a prompt template.
- Chip list (in order):
  1. Symptom check
  2. Is this urgent?
  3. Diet advice
  4. Behaviour question
  5. Vet visit prep
  6. Medication reminder
- Chip style: `AppColors.lavenderLight` background, `AppColors.lavenderDeep` text, `AppFonts.captionL`, 20px border radius, 12px horizontal padding.

### Bottom Input Bar
- Fixed at bottom, above the keyboard safe area.
- Layout (left → right):
  - **Photo button** (`📷`) — large tap target (≥ 44px), opens a picker: camera or photo library.
  - **Text input** (centre, flexible width) — `AppTextField`, placeholder "Ask me anything…".
  - **Send button** — large tap target (≥ 44px), caramel color, disabled state when input is empty.
- Icons for photo and send must be **larger than standard** (28–32px icon size).
- Attached photos display as a thumbnail preview row above the input bar before sending.

---

## 3. UI & Design Constraints

- All colors from `AppColors.*` — no raw hex values.
- All text styles from `AppFonts.*` — no raw `TextStyle`.
- Reuse existing common widgets wherever applicable (`AppButton`, `AppTextField`, `DialogFrame`, `BaseCachedNetworkImage`, `Bouncing`, etc.).
- Screen logic lives in `ChatController` (extends `SafeChangeNotifier`); UI files are widget-only.
- Follow the screen structure convention:
  ```
  lib/layout/screens/chat/
  ├── controller/
  │   └── chat_controller.dart
  └── ui/
      ├── chat_screen.dart
      └── widgets/
          ├── chat_message_bubble.dart
          ├── chat_message_list.dart
          ├── chat_input_bar.dart
          ├── chat_quick_tasks_row.dart
          └── chat_typing_indicator.dart
  ```
- Chat home screen follows the same pattern under `lib/layout/screens/chat_home/`.

---

## 4. Navigation

- Chat Home is a **main tab** or accessible from the bottom navigation bar.
- Tapping a chat history item navigates to the Chat Screen for that session.
- Tapping "+" navigates to a new Chat Screen with an empty session.
- Back from Chat Screen returns to Chat Home.

---

## 5. Out of Scope (for this version)

- Push notifications for AI replies.
- Chat search/filter.
- Multi-pet session tagging.
- Export or share chat transcript.
