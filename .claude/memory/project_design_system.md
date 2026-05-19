---
name: project-design-system
description: Catti design system migration — new color/font tokens replacing the old blue palette
metadata:
  type: project
---

The app was migrated from a blue-centric design system to the **Catti** design language (caramel + lavender, warm neutrals).

**Key changes made (2026-05-18):**
- `AppColors` now has caramel/lavender/neutral tokens. Old names (`textPrimary`, `primaryColor`, etc.) are kept as aliases pointing to new values.
- `AppFonts` split into brand font (Nunito, Kenfolg stand-in) and body font (system default = SF Pro on iOS). Existing `f*` styles still exist but use system font.
- `AppButton` defaults: 56px height, 28px pill radius, caramel gradient, caramel shadow.
- Bottom nav: caramel active state, stone inactive, caramel pill indicator behind active icon.
- Chat bubbles: caramel user bubble (20/20/20/4 radius), white AI bubble with 3px lavender left border.
- `ChatTypingIndicator` is now a `StatefulWidget` with animated 3 lavender dots ("PurrCheck is thinking...").
- All screen backgrounds use `AppColors.appBackground` (#FEFDFB warm white).

**Why:** Carrothon 2026 rebrand per `docs/design-language.md`.

**How to apply:** Always use caramel (`AppColors.caramel`) as primary, lavender (`AppColors.lavender`) for AI elements. Use `AppFonts.h1`–`h4` and `AppFonts.ctaPrimary` for brand text, `AppFonts.bodyM`/`captionM` for body. Never hardcode hex or TextStyle.

**Kenfolg font:** Not yet licensed. Nunito is the current stand-in. When the real font file is added, update `brandFont()` in `app_font.dart` to load it via `pubspec.yaml` fonts section.
