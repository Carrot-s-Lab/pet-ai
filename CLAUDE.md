# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## UI Rules (enforce these always)

These rules apply to ALL UI work — no exceptions, even for quick prototypes or placeholder screens.

**1. Use the design system tokens — never hardcode values.**
- Colors → always `AppColors.*` from `lib/layout/common/color/app_color.dart`. Never write a raw hex string (`Color(0xFF...)` or `Colors.*`).
- Typography → always `AppFonts.*` from `lib/layout/common/app_font/app_font.dart`. Never write a raw `TextStyle(fontSize: ..., fontWeight: ...)`.
- If a color or text style is needed that doesn't exist in the design system, flag it and ask before inventing one.

**2. Reuse common widgets — don't reinvent them.**
- Before writing any button, input, dialog, image, or layout wrapper, check `lib/layout/common/` first.
- Key widgets to always reach for: `AppButton`, `AppTextField`, `CommonAppBar`, `MainScaffold`, `Bouncing`, `HighlightOnTap`, `BaseCachedNetworkImage`, `SnackBarService`, `DialogFrame`.
- Only create a new widget if nothing in `common/` covers the use case.

**3. Keep screen files thin — no logic in the UI layer.**
- Screen files (`lib/layout/screens/`) build widgets only. No API calls, no data transformation, no business logic.
- Any state or logic belongs in the screen's controller (e.g. `HomeController`). If a controller doesn't exist yet, create one extending `SafeChangeNotifier` and register it in `AppProviders`.

---

## App Overview

**Pet AI** is a mobile application (iOS-first) for pet owners. It uses AI features via Firebase AI and provides a multi-language experience. The app is in early development — core infrastructure is in place, feature screens are being built out.

**Supported languages:** English (default), Vietnamese, Korean, Chinese

---

## Flutter Version

This project uses Flutter **3.41.2** via FVM. Always prefix Flutter commands with `fvm`:

```bash
fvm flutter run
fvm flutter build ios
fvm flutter test
fvm flutter pub get
fvm flutter pub run intl_utils:generate   # regenerate localization files
```

## Common Commands

```bash
fvm flutter analyze          # lint check
fvm flutter test             # run all tests
fvm flutter test test/widget_test.dart   # run single test file
fvm flutter pub run intl_utils:generate  # after editing lib/l10n/*.arb files
```

---

## Project Structure

```
lib/
├── main.dart                     # Entry point
├── firebase_options.dart         # Firebase config (iOS)
├── core/                         # Infrastructure layer
│   ├── api/                      # Dio HTTP client + interceptors
│   ├── services/                 # LocalDatabaseService (SharedPreferences)
│   ├── app_config/               # EnvConfig (loads .env)
│   ├── locator/                  # GetIt service locator setup
│   ├── initialization/           # Pre-run setup (bindings, router, locator)
│   ├── locale/                   # LocaleModel definitions
│   ├── extensions/               # Dart extensions (color, string, context…)
│   └── utils/                    # Global helpers (screen size, clipboard…)
├── layout/                       # UI layer
│   ├── app/                      # Root widget, MultiProvider, language controller
│   ├── screens/                  # Feature screens (see below)
│   └── common/                   # Reusable widgets and design system
├── router/                       # GoRouter setup + route path constants
├── l10n/                         # ARB translation files (edit here)
└── generated/                    # Auto-generated code — do NOT edit
```

---

## Architecture

**Initialization flow:** `main.dart` → `InitializationService` (env, get_it locator, GoRouter, SharedPreferences) → `App` widget → `AppProviders` (MultiProvider) → `AppRouter`

**Dependency injection:** `get_it` service locator. Services registered in `InitializationService`. Retrieve with `locator<T>()`.

**State management:** `provider` + `ChangeNotifier`. Controllers extend `SafeChangeNotifier` (guards `notifyListeners()` after disposal). Register new controllers in `AppProviders` (`lib/layout/app/app_provider.dart`).

**Navigation:** `GoRouter` via `AppRouter` wrapper (`lib/router/router.dart`). Stateful shell routes preserve tab state. Use `context.go()` / `context.push()` or `appRouter.go()` / `appRouter.push()`.

**HTTP:** `BaseDio` in `lib/core/api/`. Base URL from `.env` (`BASE_URL`). Supports auth token header and culture code header for i18n.

---

## Screens

All screens are in `lib/layout/screens/`.

| Screen | Path constant | Status | Notes |
|--------|--------------|--------|-------|
| `splash/splash_screen.dart` | `/splash` | Done | Plays `assets/videos/cattie_splash.mp4` then navigates to home |
| `home/home_screen.dart` | `/home` | In progress | Main home tab; `HomeController` wired up |
| `account/account_screen.dart` | `/account` | Placeholder | Account/profile tab |

**Navigation structure:**
- App starts at `/splash`
- After splash → `/home`
- Bottom nav bar switches between `/home` (tab 0) and `/account` (tab 1) using `StatefulShellRoute.indexedStack` — tab state is preserved when switching

---

## Design System

Design language: **Catti** — warm caramel/lavender palette, Nunito brand font (Kenfolg stand-in), SF Pro body text. See `docs/design-language.md` for the full spec.

### Colors — `lib/layout/common/color/app_color.dart`

**Brand (Caramel)**
| Name | Hex | Usage |
|------|-----|-------|
| `caramel` | `#D39654` | Primary CTA, active tab, key brand moments |
| `caramelDeep` | `#B87A3A` | Pressed states, caramel borders |
| `caramelLight` | `#F2DFC0` | Tinted card backgrounds, active nav indicator |
| `caramelWash` | `#FBF5EC` | Page section fills, selected surfaces |

**AI (Lavender)**
| Name | Hex | Usage |
|------|-----|-------|
| `lavender` | `#B8ACE5` | AI chat bubble accent border, typing dots |
| `lavenderDeep` | `#8E7FCC` | AI indicator fills, badges |
| `lavenderLight` | `#DDD8F5` | AI chip backgrounds |
| `lavenderWash` | `#F3F1FB` | Subtle AI surface backgrounds |

**Neutrals**
| Name | Hex | Usage |
|------|-----|-------|
| `ink` | `#1A1611` | Primary text, headings |
| `charcoal` | `#3D3529` | Secondary text |
| `stone` | `#7A6E62` | Tertiary text, placeholders, captions |
| `pebble` | `#B5ADA4` | Disabled text, dividers |
| `mist` | `#E8E3DC` | Borders, separators |
| `cloud` | `#F5F2EE` | Input fill, card backgrounds |
| `appWhite` | `#FEFDFB` | App bars, sheet surfaces |

**Semantic**
| Name | Hex | Usage |
|------|-----|-------|
| `wellness` | `#5BAD7F` | Healthy status, success |
| `amber` | `#E8A020` | Reminders, moderate concerns |
| `urgent` | `#D94040` | Vet-now flags only — use sparingly |
| `info` | `#5B8DD9` | Informational notes, links |

**Backgrounds**
| Name | Hex | Usage |
|------|-----|-------|
| `appBackground` | `#FEFDFB` | Root screen background |
| `sectionBackground` | `#FBF5EC` | Grouped sections |
| `cardSurface` | `#FFFFFF` | Elevated card surfaces |
| `inputSurface` | `#F5F2EE` | Text inputs, search bars |

Old names (`textPrimary`, `primaryColor`, `borderPrimary`, etc.) are kept as aliases — they now resolve to the new palette values.

### Typography — `lib/layout/common/app_font/app_font.dart`

Two font tracks:
- **Brand (Nunito)** — headings, CTAs, display text. Kenfolg stand-in; swap once the real font file is licensed.
- **Body (system default)** — body copy, AI responses, captions. Resolves to SF Pro on iOS.

**Semantic styles (preferred for new screens)**
| Style | Font | Size | Weight | Usage |
|-------|------|------|--------|-------|
| `displayXl` | Brand | 40px | Bold | Splash hero headline |
| `displayL` | Brand | 32px | SemiBold | Onboarding hero |
| `displayM` | Brand | 28px | SemiBold | Paywall headline |
| `h1` | Brand | 26px | SemiBold | Screen titles |
| `h2` | Brand | 22px | SemiBold | Card titles, section headers |
| `h3` | Brand | 18px | Medium | Subsection headers |
| `h4` | Brand | 16px | Medium | Card labels |
| `ctaPrimary` | Brand | 17px | SemiBold | Primary buttons |
| `ctaSecondary` | Brand | 15px | Medium | Secondary actions |
| `ctaTertiary` | Brand | 14px | Regular | Skip / restore links |
| `bodyL` | Body | 17px | Regular | Primary body text |
| `bodyM` | Body | 15px | Regular | Standard body, card content |
| `bodyS` | Body | 13px | Regular | Supporting text, notes |
| `captionL` | Body | 13px | Medium | Chip labels |
| `captionM` | Body | 12px | Regular | Timestamps, metadata |
| `captionS` | Body | 11px | Regular | Legal, fine print |

**Legacy `f*` styles** (`f14r`, `f16s`, etc.) still exist and use the body (system) font — safe to use in existing code, but prefer the semantic styles above for any new UI.

### Spacing & Layout conventions

- Primary CTA: 56px height, 28px radius (pill), caramel gradient
- Input: 48px height, 14px radius, `cloud` fill, caramel focus border
- Cards: 20px radius, `cardSurface` (#FFF) background, warm shadow
- Safe area insets handled by `SafeArea` widgets; global `sTOPSAFEAREA` / `sBOTTOMSAFEAREA` from `lib/core/utils/global.dart`
- Global screen dimensions: `sWIDTH`, `sHEIGHT` (set once in `InitializationService`)

---

## Common Widgets — `lib/layout/common/`

### Buttons
| Widget | File | Description |
|--------|------|-------------|
| `AppButton` | `buttons/app_button.dart` | Primary button with gradient support |
| `AppBackButton` | `buttons/app_back_button.dart` | Circular back navigation button |
| `AppCircleButton` | `buttons/app_circle_button.dart` | Icon-only circular button |
| `AppTextButton` | `buttons/app_text_button.dart` | Text-only button |

### Inputs
| Widget | File | Description |
|--------|------|-------------|
| `AppTextField` | `text_field/app_text_field.dart` | Customizable form input (border, hint, icons) |
| `AppValidator` | `app_validator/app_validator.dart` | Input validation utilities |

### Layout & Navigation
| Widget | File | Description |
|--------|------|-------------|
| `MainScaffold` | `main_scaffold/main_scaffold.dart` | Root scaffold wrapping the tab shell |
| `MainBottomNavigationBar` | `bottom_navigator_bar/` | Two-tab bottom nav with SVG icons (Home, Account) |
| `CommonAppBar` | `app_bar/common_app_bar.dart` | Reusable top app bar with back button and action slots |
| `AppScreenFrame` | `app_screen_frame/` | Standard screen layout wrapper |

### Dialogs & Sheets
| Widget | File | Description |
|--------|------|-------------|
| `DialogFrame` | `dialog_frame/dialog_frame.dart` | Base modal wrapper (tap-outside to dismiss) |
| `LoadingDialog` | `loading_dialog/` | Progress/loading overlay |
| `ChoicesDialog` | `dialogs/choices_dialog.dart` | Multi-option choice dialog |
| `TextDialog` | `dialogs/text_dialog.dart` | Simple text-only dialog |
| `DeleteAccountDialog` | `dialogs/delete_account_dialog.dart` | Account deletion confirmation |
| `ListPickerDialog` | `list_picker_dialog/` | Scrollable item picker |
| `ListStringSelectorDialog` | `list_string_selector_dialog/` | Multi-select list with controller |
| `CustomBottomSheetDialog` | `bottom_sheet/` | Bottom sheet container |

### Interaction & Animation
| Widget | File | Description |
|--------|------|-------------|
| `Bouncing` | `bouncing/bouncing.dart` | Tap scale animation (press feedback) |
| `HighlightOnTap` | `highlight_on_tap/` | InkWell with customizable highlight color |
| `KeyboardDismissOnTap` | `keyboard_dismiss/` | Dismisses keyboard when tapping background |

### Display
| Widget | File | Description |
|--------|------|-------------|
| `BaseCachedNetworkImage` | `cached_network_image/` | Cached image with border radius + error fallback |
| `SectionTitle` | `section_title/` | Reusable section header label |
| `PercentageTag` | `percentage_tag/` | Badge showing a percentage value |
| `ButtonsIndicator` | `buttons_indicator/` | Multi-step progress dots |
| `SnackBarService` | `snack_bar/` | Toast notifications — `.success()`, `.error()`, `.warning()` |

---

## State / Controllers

| Controller | Provider registration | Purpose |
|-----------|----------------------|---------|
| `AppLanguageController` | `AppProviders` | Current locale; syncs with storage and API `cultureCode` header |
| `HomeController` | `AppProviders` | Home screen state (placeholder) |
| `DeleteAccountController` | local to dialog | Account deletion flow |
| `ListStringSelectorController` | local to dialog | Multi-select list picker state |

---

## Screen Structure Convention

Every screen lives under `lib/layout/screens/<screen_name>/` and **must** follow this layout:

```
lib/layout/screens/<screen_name>/
├── controller/
│   └── <screen_name>_controller.dart   # ChangeNotifier — state + business logic only
└── ui/
    ├── <screen_name>_screen.dart        # Scaffold + Consumer, assembles widgets, no raw logic
    └── widgets/                         # One file per component, accepts plain params
        ├── <component_a>.dart
        └── <component_b>.dart
```

**Rules:**
- `controller/` — pure logic, no `BuildContext`, no Flutter widgets, extends `SafeChangeNotifier`
- `ui/<screen>_screen.dart` — reads from controller via `Consumer`/`context.read`, delegates all actions to controller, keeps `build()` lean
- `ui/widgets/` — stateless widgets that receive data and callbacks as constructor params; no direct provider reads inside widgets
- Avoid putting more than one logical component in a single widget file
- Use `package:pet_ai_project/...` absolute imports (not relative `../../`) across layer boundaries

**Registering a new screen:**
1. Create the folder structure above
2. Add route path in `lib/router/route_paths.dart`
3. Wire route in `lib/router/routes.dart` — wrap with `ChangeNotifierProvider(create: (_) => <Screen>Controller())`
4. Register any new services/repositories in `lib/core/locator/locator.dart`

**Example (chat screen):**
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
        ├── chat_pending_images_bar.dart
        └── chat_typing_indicator.dart
```

## UI Language

**Default language for all UI text is English.** This applies to every screen, widget, dialog, error message, hint text, and permission description. Do not hardcode Vietnamese strings in UI files. The only exception is user-generated content (e.g. chat messages).

## Localization

Strings live in `lib/l10n/*.arb`. After editing, run:

```bash
fvm flutter pub run intl_utils:generate
```

Localizely OTA updates are enabled — do not hardcode user-facing strings.

**Current string keys (`intl_en.arb`):**
- `somethingWentWrong`, `emptyField`, `information`, `emptyInformation`
- `allFieldsAreRequired`, `invalidEmail`
- `home`, `account`

Access in code: `Tr.of(context).home`

---

## Key Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `go_router` | ^17.2.3 | Declarative routing |
| `provider` | ^6.1.5 | State management |
| `get_it` | ^9.2.1 | Service locator / DI |
| `dio` | ^5.9.2 | HTTP client |
| `firebase_core/auth/firestore/messaging/ai` | ^4–6 | Firebase integration |
| `firebase_app_check` | ^0.4.4 | Security |
| `shared_preferences` | ^2.5.5 | Local persistence |
| `flutter_dotenv` | ^6.0.1 | Environment config |
| `video_player` | ^2.11.1 | Splash screen video |
| `cached_network_image` | ^3.4.1 | Network image caching |
| `flutter_svg` | ^2.3.0 | SVG rendering |
| `google_fonts` | ^8.1.0 | Mulish font |
| `gap` | ^3.0.1 | Spacing shorthand |
| `localizely_sdk` | ^2.7.5 | OTA translation updates |
| `app_tracking_transparency` | ^2.0.6 | iOS IDFA prompt |

---

## Linting Notes

`analysis_options.yaml` enforces `prefer_single_quotes` and `prefer_const_constructors`. `use_build_context_synchronously` and `unused_element` are suppressed. `print` statements are allowed.
