# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

## Architecture

**Initialization flow:** `main.dart` → `InitializationService` (sets up env, get_it locator, GoRouter, SharedPreferences DB) → `App` widget → `AppProviders` (MultiProvider) → `AppRouter`.

**Layer structure:**
- `lib/core/` — Infrastructure: API client (Dio), local storage (SharedPreferences wrapper), env config (flutter_dotenv), utilities
- `lib/layout/` — All UI: `app/` (root widget + providers), `screens/` (feature screens), `common/` (40+ reusable widgets/dialogs)
- `lib/router/` — GoRouter setup with stateful shell routes for tab navigation
- `lib/generated/` — Auto-generated localization code (do not edit manually)
- `lib/l10n/` — ARB translation files (edit these to change strings)

**Dependency injection:** `get_it` service locator; services registered in `InitializationService` as singletons/lazy singletons. Retrieve via `GetIt.instance<T>()` or the `locator<T>()` shorthand.

**State management:** `provider` with `ChangeNotifier`. Controllers extend `SafeChangeNotifier` (a wrapper that guards against `notifyListeners()` after disposal). Register new controllers in `AppProviders`.

**Navigation:** `GoRouter` via `AppRouter`. Uses stateful shell routes to preserve tab state. Navigate with `context.go()` / `context.push()`.

**HTTP:** `Dio` instance configured in `core/api/`. Environment-based base URL via `flutter_dotenv` (`.env` file, not committed).

## Localization

Strings live in `lib/l10n/*.arb` files. After editing them, run:

```bash
fvm flutter pub run intl_utils:generate
```

Localizely OTA updates are enabled — avoid hardcoding strings that should be translatable.

## Linting Notes

`analysis_options.yaml` enforces `prefer_single_quotes` and `prefer_const_constructors`. `use_build_context_synchronously` and `unused_element` are suppressed. `print` statements are allowed.
