# Design Language Document
## Catti — Cat AI Health Assistant
**Version 1.0 · Carrothon 2026 · Team C**

---

# 1. Brand Personality

## Core Attributes

Catti occupies a rare emotional space in consumer apps: it is simultaneously a trusted medical advisor and a warm companion. The design system must hold both of those truths at once — never tipping into cold clinical territory, never slipping into childish cuteness.

| Attribute | Expression |
|---|---|
| **Warm** | Caramel tones, soft surfaces, rounded geometry, no hard edges |
| **Confident** | Clear hierarchy, decisive type sizing, AI responses feel authoritative without being alarmist |
| **Trustworthy** | Consistent visual system, no cheap gradients, elevated component quality |
| **Caring** | Personalisation starts at the first question — every screen knows the cat's name |
| **Intelligent** | AI-native patterns: typing indicators, analysis states, confidence levels — all legible and sophisticated |
| **Premium but approachable** | 3D mascot quality, not clip art; material feel without exclusion |

## Emotional Direction

When a user opens Catti at 2am because their cat is acting strange, they should feel:

> "This knows my cat. I'm not alone in this."

That feeling — relief, competence, calm — is the emotional north star for every design decision. The interface should feel like a knowledgeable friend who happens to be a vet, not an emergency hotline and not a generic chatbot.

## Design Principles

**1. Personalisation is visual.** The cat's name, photo, and profile should appear everywhere they are contextually relevant. The home screen is *Luna's* home screen, not a generic dashboard.

**2. Warmth through materiality.** Soft shadows, gentle gradients from caramel to white, and surfaces that feel slightly tactile — not flat neutral grey cards.

**3. Confidence through restraint.** The AI layer earns trust through calmness. No aggressive animations, no alarming red states unless clinically warranted. Most interactions should feel smooth and deliberate.

**4. Care through spacing.** Information is never compressed. White space communicates "we have time for you." Tight layouts feel clinical; airy layouts feel caring.

**5. Delight lives in details.** Subtle micro-moments — the mascot reacting to a health milestone, a streaking caramel progress ring — are meaningful because they are earned, not constant.

## Personality Spectrum

```
CLINICAL ←————————————————————————→ PLAYFUL
          Catti sits here ●
     (trusted + warm, never medical-cold, never toy-like)
```

---

# 2. Visual Direction

## Core Visual Identity

Two reference signals define the visual direction:

**UI Reference (Pet App):** Validates the component direction — pastel card backgrounds (mint, peach, lilac, sky), floating pill-shaped bottom navigation, rounded search bars, category icon chips. This shows what a warm, friendly, premium pet app looks like at the component level. The composition is light, airy, generous with white space.

**Mascot Reference (3D Cat):** This is the art direction for the illustration system. The orange tabby on periwinkle background is rendered with extraordinary softness — fur has sculpted volume without hard edges, the pose is completely relaxed and trusting, and the colour combination (warm amber against cool lavender) is exactly the PRD's `#D39654` / `#B8ACE5` palette in physical form. This is not a coincidence — it is the brand visualised as a creature.

## Art Direction

**Material quality:** Surfaces should feel like soft matte ceramic, not glass or plastic. Cards have gentle elevation with warm-tinted shadows (not grey). The overall feel is matte + warm, not glossy + cool.

**Shape language:** Exclusively rounded. Radii of 16px–32px on cards, 100px (fully rounded) on pills, chips, and CTAs. No sharp corners anywhere in the primary UI. Rounded shapes communicate safety and approachability — sharp angles signal threat; curves signal safety.

**Visual density:** Medium-low. Each screen has one primary job. Onboarding screens are near-empty with a single question. Home is list-based but never crammed. The AI chat is standard conversation density.

**Composition rules:**
- One visual anchor per screen (illustration, cat photo, or large headline)
- Supporting content below the fold where possible
- Bottom navigation always visible — never hidden
- Full-bleed gradients only on onboarding screens; content screens use white/off-white bases

**What to avoid:**
- Blue-heavy palettes that read as healthcare/hospital
- Generic white card + grey text layouts
- Illustrative line art (too flat for the premium 3D mascot direction)
- Heavy dark mode styling as default (warm light theme is the brand)
- Clinical red as a primary colour — reserve for genuine emergency states only

---

# 3. Color System

## Primary Palette

| Name | HEX | RGB | Usage |
|---|---|---|---|
| **Caramel** | `#D39654` | 211, 150, 84 | Primary CTA, active tab, streaks, key brand moments |
| **Caramel Deep** | `#B87A3A` | 184, 122, 58 | Pressed states, borders on caramel elements |
| **Caramel Light** | `#F2DFC0` | 242, 223, 192 | Tinted card backgrounds, onboarding gradients |
| **Caramel Wash** | `#FBF5EC` | 251, 245, 236 | Page backgrounds, section fills |

## Secondary / AI Palette

| Name | HEX | RGB | Usage |
|---|---|---|---|
| **Lavender** | `#B8ACE5` | 184, 172, 229 | AI chat accents, streak badges, highlights, selected states |
| **Lavender Deep** | `#8E7FCC` | 142, 127, 204 | AI indicator dots, confidence level fills |
| **Lavender Light** | `#DDD8F5` | 221, 216, 245 | AI response bubble tint, lavender chip backgrounds |
| **Lavender Wash** | `#F3F1FB` | 243, 241, 251 | Subtle AI surface backgrounds |

## Neutral Palette

| Name | HEX | Usage |
|---|---|---|
| **Ink** | `#1A1611` | Primary text, headings — warm black, not pure `#000` |
| **Charcoal** | `#3D3529` | Secondary text, subheadings |
| **Stone** | `#7A6E62` | Tertiary text, placeholders, captions |
| **Pebble** | `#B5ADA4` | Disabled text, dividers |
| **Mist** | `#E8E3DC` | Borders, separators — warm not cool grey |
| **Cloud** | `#F5F2EE` | Card backgrounds, input fills — warm off-white |
| **White** | `#FEFDFB` | True backgrounds — very slightly warm white |

## Semantic Colors

| Name | HEX | Usage |
|---|---|---|
| **Wellness Green** | `#5BAD7F` | Healthy status, completed tasks, positive insights |
| **Alert Amber** | `#E8A020` | Reminders, upcoming vet visits, moderate concerns |
| **Urgent Red** | `#D94040` | Vet-now flags only — strictly for `"Please contact your vet now."` states |
| **Info Blue** | `#5B8DD9` | Informational notes, link text |

> **Critical rule for Urgent Red:** This colour must only appear when the AI triggers the emergency protocol (48h no eating, no urinating, seizure). Its scarcity is what gives it meaning. If it appears on routine elements, the emergency state loses its power.

## Background System

| Level | Color | Usage |
|---|---|---|
| **App background** | `#FEFDFB` | Root screen background |
| **Section background** | `#FBF5EC` | Grouped sections, soft dividers |
| **Card surface** | `#FFFFFF` | Elevated card backgrounds |
| **Input surface** | `#F5F2EE` | Text input fields, search bars |
| **Modal overlay** | `rgba(26,22,17,0.45)` | Sheet/modal backdrop — warm-tinted black |

## Gradient Language

Gradients should be used sparingly and only where they add warmth, never for decoration.

```css
/* Hero gradient — onboarding full-bleed */
background: linear-gradient(180deg, #F2DFC0 0%, #FEFDFB 55%, #FEFDFB 100%);

/* CTA gradient — primary button */
background: linear-gradient(145deg, #E0A55E 0%, #D39654 100%);

/* AI response accent line */
background: linear-gradient(180deg, #B8ACE5 0%, #DDD8F5 100%);
```

Every gradient should feel like warm light through a window, not a tech product feature. Avoid: rainbow gradients, dark-to-light gradients as backgrounds, mesh gradients, neon or saturated gradients.

## Accessibility

| Pair | Contrast | Status |
|---|---|---|
| Ink `#1A1611` on Cloud `#F5F2EE` | 14.2:1 | AAA ✓ |
| Charcoal `#3D3529` on White | 10.8:1 | AAA ✓ |
| Stone `#7A6E62` on White | 5.1:1 | AA ✓ |
| White on Caramel `#D39654` | 3.2:1 | AA Large ✓ (bold text only) |

All interactive tap targets minimum 44×44pt per iOS HIG.

---

# 4. Typography System

## Font: Kenfolg

Kenfolg is Catti's display and brand voice font. It carries the personality — warm, rounded, slightly playful but mature — in every headline and label. It pairs with **SF Pro** (system font) for body copy and utility text, maintaining iOS-native fluency while stamping every screen with Catti's character.

**Pairing rule:** Kenfolg for anything the *brand* says (headings, CTAs, onboarding questions, app name). SF Pro for anything *informational* (body paragraphs, AI responses, data, timestamps). Never use Kenfolg below 13px — it loses legibility at caption scale.

## Type Scale

### Display (Kenfolg)

| Style | Size | Weight | Line Height | Tracking | Usage |
|---|---|---|---|---|---|
| **Display XL** | 40px | Bold | 46px | -0.5px | App name on splash, hero onboarding headline |
| **Display L** | 32px | SemiBold | 38px | -0.3px | "Meet your cat's AI care companion" |
| **Display M** | 28px | SemiBold | 34px | -0.2px | Paywall headline, section heroes |

### Headings (Kenfolg)

| Style | Size | Weight | Line Height | Tracking | Usage |
|---|---|---|---|---|---|
| **H1** | 26px | SemiBold | 32px | -0.2px | Screen titles, chat header |
| **H2** | 22px | SemiBold | 28px | -0.1px | Card titles, section headers |
| **H3** | 18px | Medium | 24px | 0px | Subsection headers, task group labels |
| **H4** | 16px | Medium | 22px | 0px | Card labels, category names |

### Body (SF Pro)

| Style | Size | Weight | Line Height | Tracking | Usage |
|---|---|---|---|---|---|
| **Body L** | 17px | Regular | 26px | 0px | Primary body — AI responses, onboarding subheads |
| **Body M** | 15px | Regular | 22px | 0px | Standard body — task descriptions, card content |
| **Body S** | 13px | Regular | 19px | 0.1px | Supporting text, notes, secondary card info |

### Captions (SF Pro)

| Style | Size | Weight | Line Height | Tracking | Usage |
|---|---|---|---|---|---|
| **Caption L** | 13px | Medium | 18px | 0.2px | Chip labels, category text under icons |
| **Caption M** | 12px | Regular | 16px | 0.3px | Timestamps, metadata, distance labels |
| **Caption S** | 11px | Regular | 14px | 0.4px | Legal text, paywall fine print |

### CTA (Kenfolg)

| Style | Size | Weight | Tracking | Usage |
|---|---|---|---|---|
| **CTA Primary** | 17px | SemiBold | 0.2px | "Get started", "Start free trial" |
| **CTA Secondary** | 15px | Medium | 0.1px | Secondary actions, sheet CTAs |
| **CTA Tertiary** | 14px | Regular | 0px | "Skip for now", "Restore purchase" |

### AI Chat

| Speaker | Font | Size | Notes |
|---|---|---|---|
| User bubble | SF Pro | 16px Regular | Right-aligned, caramel bubble |
| AI response | SF Pro | 16px Regular | Left-aligned, white card |
| AI structured heading | Kenfolg H3 | 18px Medium | When AI formats a structured answer |
| AI disclaimer | SF Pro Caption M | 12px Stone | Always appended to AI responses |
| Quick Task chip | SF Pro Caption L | 13px Medium | Horizontal scroll chips |

## Mobile Rules

- Never kern Kenfolg tighter than -0.5px — the letterforms need room
- Do not use Kenfolg below 13px — switch to SF Pro
- Line length: 30–45 characters for body (approximately 320px container at 17px)
- Avoid all-caps Kenfolg — it was not designed for it and loses character
- Allow SF Pro body text to scale with Dynamic Type; Kenfolg headlines can be fixed

---

# 5. Layout & Spacing System

## Base Unit

**8px grid.** All spacing values are multiples of 4px, with primary steps at 8px intervals.

## Spacing Scale

| Token | Value | Usage |
|---|---|---|
| `space-2` | 2px | Internal chip padding edge |
| `space-4` | 4px | Icon-to-label gap, tight element pairs |
| `space-8` | 8px | Component internal padding, row gaps |
| `space-12` | 12px | Card internal padding (compact) |
| `space-16` | 16px | Standard card padding, section gaps |
| `space-20` | 20px | Screen horizontal margins |
| `space-24` | 24px | Card padding (standard), vertical section spacing |
| `space-32` | 32px | Large section gaps, illustration margins |
| `space-40` | 40px | Hero section spacing |
| `space-48` | 48px | CTA button to safe area bottom |
| `space-64` | 64px | Full-bleed illustration spacing |

## Screen Margins

- **Horizontal screen margin:** 20px (all content screens)
- **Onboarding margin:** 24px (single-question screens need more room)
- **Safe area bottom:** 34px (iPhone Dynamic Island devices) — always account for home indicator

## Grid System

- **Single column:** Primary layout for all content screens
- **2-column grid:** Pet cards in Explore, category chips. Column gap: 12px
- **Horizontal scroll:** Category chips, Quick Task chips — no pagination dots

## Vertical Screen Rhythm

```
[Status bar — 44pt]
[Navigation / screen title — 52pt]
[Primary content — flexible]
[Fixed bottom action OR bottom nav — 72pt]
[Safe area — 34pt]
```

On onboarding screens, the single question is vertically centred in the available space with the CTA pinned to the bottom.

## Spacing Philosophy

Space communicates care. The most stressful screens (symptom check, urgency assessment) must have the most space, not the least. If a screen feels too airy, it is probably right for this product.

---

# 6. Component Design Language

## Buttons

### Primary CTA
```
Background:   linear-gradient(145deg, #E0A55E 0%, #D39654 100%)
Text:         #FFFFFF, Kenfolg SemiBold 17px
Height:       56px
Radius:       28px (pill)
Shadow:       0 4px 16px rgba(211,150,84,0.35)
Padding:      0 24px

States:
  Pressed:   scale(0.97), shadow → 0 2px 8px rgba(211,150,84,0.2), 160ms ease-out
  Disabled:  opacity 0.4, no shadow
  Loading:   caramel spinner replaces label
```

### Secondary Button
```
Background:   transparent
Border:       1.5px solid #D39654
Text:         #D39654, Kenfolg Medium 15px
Height:       48px
Radius:       24px
```

### Tertiary / Link
```
Background:   none
Text:         Stone #7A6E62, SF Pro Regular 14px
```

---

## Cards

### Standard Content Card
```
Background:   #FFFFFF
Radius:       20px
Shadow:       0 2px 12px rgba(26,22,17,0.07), 0 1px 3px rgba(26,22,17,0.04)
Padding:      16px
```

### Pet Profile Card (tinted)
```
Background:   pastel tint per cat (Caramel Light, Lavender Light, mint, peach)
Radius:       20px
Shadow:       0 2px 8px rgba(0,0,0,0.06)
Image:        PNG cutout, extends beyond card top edge by ~20% for depth
```

### Task Row
```
Background:   #FFFFFF
Height:       64px
Radius:       12px
Left:         checkbox 24×24 (caramel when checked)
Middle:       task title Body M Ink + optional note Caption M Stone
Right:        timestamp Caption M — Amber if due soon, Stone if future
Done state:   text Stone + strikethrough, checkbox filled caramel
```

---

## AI Chat Bubbles

### User Bubble
```
Background:         #D39654
Text:               #FFFFFF, SF Pro Body M
Radius:             20px 20px 4px 20px
Max width:          75% of screen
Padding:            12px 16px
Shadow:             0 2px 8px rgba(211,150,84,0.3)
Photo attachment:   thumbnail above text, radius 12px, max 200px height
```

### AI Response Bubble
```
Background:   #FFFFFF
Left border:  3px solid #B8ACE5
Text:         #1A1611, SF Pro Body M
Radius:       4px 20px 20px 20px
Max width:    82% of screen
Padding:      14px 16px
Shadow:       0 2px 12px rgba(26,22,17,0.07)
Disclaimer:   Caption M, Stone, italic — always present
```

### AI Typing Indicator
```
Three dots, Lavender #B8ACE5
Animation: translateY(0 → -6px → 0), 600ms ease-in-out, loop
  Dot 1: delay 0ms
  Dot 2: delay 120ms
  Dot 3: delay 240ms
Caption: "PurrCheck is thinking..."
```

---

## Inputs

### Text Input / Search
```
Background:   #F5F2EE
Radius:       14px
Height:       48px
Padding:      0 16px
Border:       none at rest → 1.5px solid #D39654 on focus
Text:         SF Pro Body M, Ink
Placeholder:  SF Pro Body M, Pebble #B5ADA4
```

### Wheel Picker (Age)
```
Selected item:      Kenfolg H3 SemiBold, Ink
Unselected items:   SF Pro Body M, Pebble, scale 0.9
Selection band:     caramel-tinted, 44px height, radius 10px
```

---

## Navigation

### Floating Pill Navigation (Recommended)
```
Container:      background #1A1611, radius 32px, height 64px, width ~220px, centred
Floating:       positioned above safe area at 12px bottom margin
Active icon:    caramel fill + Kenfolg Caption L label
Inactive icon:  white at 60% opacity
Transition:     icon fill 180ms ease-out
```

### Standard Tab Bar (fallback)
```
Background:   rgba(255,253,251,0.85) + backdrop-blur 20px
Height:       72px
Active tab:   caramel icon + Kenfolg Caption L
Inactive tab: stone icon + SF Pro Caption M
Indicator:    caramel pill 48×32px behind active icon, radius 16px
```

---

## Bottom Sheet
```
Background:   #FEFDFB
Radius:       28px 28px 0 0
Handle:       4×36px, Mist, radius 2px, centred, 8px from top
Shadow:       0 -8px 32px rgba(26,22,17,0.12)
Padding:      24px
Max height:   75% viewport
Dismiss:      swipe down, velocity threshold > 0.11
```

---

## Chips & Toggles

### Selection Chip
```
Background rest:      Cloud #F5F2EE
Background selected:  Caramel Light #F2DFC0
Border selected:      1px solid #D39654
Text rest:            SF Pro Caption L, Stone
Text selected:        SF Pro Caption L, Caramel Deep
Radius:               20px
Height:               36px
Padding:              0 16px
```

### Category Icon Chip
```
Container:    72×88px, radius 20px
Background:   White + Mist border 1px
Icon:         32×32px, caramel or tint
Label:        Caption L, Stone
Selected:     Caramel Light background, caramel icon
```

---

## Progress Indicators

### Onboarding Progress Dots
```
Dot size:         6px
Active dot:       Caramel #D39654, expands to 20px pill width
Inactive dot:     Mist #E8E3DC
Gap:              6px
Transition:       200ms ease-out
```

### Streak Ring
```
Size:         64×64px
Track:        Mist #E8E3DC, 4px stroke
Fill:         Caramel gradient, 4px stroke, rounded linecap
Center:       cat avatar photo, 52×52px circle
Complete:     fills fully + gentle one-shot pulse
```

### Task Completion Bar
```
Height:   4px
Track:    Mist
Fill:     Caramel
Radius:   2px
Motion:   width transition 400ms ease-out
```

---

## Empty States
```
Illustration:   mascot in relaxed pose, 160px
Headline:       Kenfolg H2, Charcoal
Body:           SF Pro Body M, Stone, centred, max 260px width
CTA:            Primary button where action is available
```

Never write "No data". Frame as invitation:
- No tasks → "Add [cat name]'s first task today"
- No health log → "[cat name]'s health story starts here"

---

## AI Result Cards
```
Background:         #FFFFFF
Left accent border: 3px solid — Wellness Green (healthy) / Alert Amber (monitor) / Urgent Red (emergency)
Radius:             20px
Shadow:             standard card shadow
Header:             Kenfolg H3 + PurrCheck AI badge (Lavender Deep bg, white text)
Body:               SF Pro Body M, Ink
Confidence bar:     see AI Experience section
Disclaimer:         Caption M, Stone, italic, always present
```

---

## Photo Upload Area
```
Background:   Cloud #F5F2EE
Border:       1.5px dashed Mist #E8E3DC
Radius:       16px
Icon:         camera outline, 28px, Stone
Label:        "Add a photo" — Caption L, Stone
Height:       80px
Active state: border → Caramel, background → Caramel Wash
Photo added:  replaced by thumbnail card with × dismiss
```

---

## Loading States

### Skeleton Screen
```
Blocks:     Cloud background
Shimmer:    Caramel Wash sweeping left to right, 1.2s linear loop
Radius:     matches final component
```

### Inline Spinner
```
Color:      Caramel #D39654
Size:       20×20px, 1.5px stroke
Animation:  360° linear 800ms loop
```

---

# 7. Iconography

## Style Definition

**Outline default, filled on active state.** 1.5px stroke for standard icons, 2px for navigation icons (higher visual weight required at tab scale).

| Property | Value |
|---|---|
| **Grid size** | 24×24px, export at 2× and 3× |
| **Stroke weight** | 1.5px standard, 2px navigation |
| **Corner style** | Fully rounded joins and linecaps |
| **Default state** | Outline |
| **Active/selected state** | Filled, caramel |

## Color Usage

| Context | Color |
|---|---|
| Inactive icon | Stone `#7A6E62` |
| Active / selected | Caramel `#D39654` |
| On dark surface | White |
| Semantic warning | Alert Amber `#E8A020` |
| Semantic danger | Urgent Red `#D94040` |

## Recommended Library

**SF Symbols** (primary) — use rounded variant, weight Regular/Medium. Provides Cupertino-native consistency at zero cost.

**Custom Catti icons required for:** paw print, cat face, health check, streak flame, AI sparkle mark. Draw on 24×24px grid, matching 1.5px rounded stroke of SF Symbols.

## Rules

- Never mix filled and outline icons at the same hierarchy level
- Minimum icon in tap target: 20×20px within a 44×44pt touch area
- Use size-specific variants at 16px, 20px, 24px, 32px — never scale between sizes

---

# 8. Illustration & Mascot Direction

## Mascot Definition

The mascot is an orange tabby cat rendered in premium 3D. The specific qualities that must be preserved across all usage:

- **Material:** Soft, slightly matte — fur texture is sculptural, not photorealistic and not flat vector
- **Palette:** Warm amber/caramel fur (`#D39654` family) against cooler backgrounds (periwinkle/lavender `#B8ACE5` family)
- **Expression:** Eyes closed or soft — content, trusting, at peace. Never anxious, never alarmed
- **Pose vocabulary:** Stretch, curled sleep, upright attentive, head tilt curious — maximum 5 canonical poses

## Mascot Moment Map

| Trigger | Pose | Behaviour |
|---|---|---|
| First app open | Stretch | "Waking up" to meet the user |
| Onboarding complete | Upright with heart | Subtle hop, once |
| 7-day streak | Paw raise | Gentle celebration, once |
| Empty state | Curled sleep | "Nothing here yet" |
| AI analysis loading | Head tilt | Subtle thinking |
| Emergency / vet-now | **Absent** | No warmth — clinical urgency takes over |

## Size on Screen

- Hero moments: maximum 40% of screen height
- Supporting context: 25–30% of screen height
- The mascot supports; it does not host

## Illustration Style

All non-mascot illustrations (onboarding accents, empty state backgrounds) match the 3D soft-render aesthetic. Low-poly or soft 3D blob shapes in caramel and lavender tones work as page accents. **Avoid:** flat cartoon illustrations, clipart pet icons, generic AI blob/orb illustrations.

## Motion Behaviour

```
Idle breathing:   scale 1.0 → 1.02 → 1.0, 3000ms ease-in-out loop
Pose transition:  400ms spring { duration: 0.4, bounce: 0.15 }
Entrance:         translateY(8px → 0) + opacity(0 → 1), 350ms ease-out
```

The mascot never teleports — it always transitions.

---

# 9. Motion Language

## Motion Philosophy

Motion in Catti communicates calm competence. Every animation should feel like something a confident, caring entity does — deliberate, smooth, never frantic. The user should never feel like the interface is rushing them.

**Motion serves three purposes:**
1. **Spatial continuity** — where did that screen come from, where is it going?
2. **State feedback** — did the interface hear me?
3. **Emotional pacing** — this AI is thinking carefully, not just loading

## Easing Curves

```css
--ease-out-strong:    cubic-bezier(0.23, 1, 0.32, 1);      /* Entrances, screen transitions */
--ease-in-out-smooth: cubic-bezier(0.77, 0, 0.175, 1);     /* On-screen movement */
--ease-out-gentle:    cubic-bezier(0.34, 1.56, 0.64, 1);   /* Spring feel for small elements */
--ease-drawer:        cubic-bezier(0.32, 0.72, 0, 1);      /* Bottom sheet entrance */
```

## Duration Scale

| Interaction | Duration | Easing |
|---|---|---|
| Button press feedback | 160ms | `--ease-out-strong` |
| Chip / toggle selection | 180ms | `--ease-out-strong` |
| Card list entrance + stagger | 250ms + 40ms/item | `--ease-out-strong` |
| Screen push / pop | 320ms | `--ease-out-strong` |
| Bottom sheet open | 380ms | `--ease-drawer` |
| Onboarding screen transition | 280ms | `--ease-out-strong` |
| AI bubble entrance | 300ms | `--ease-out-gentle` |
| Mascot pose transition | 400ms spring | `{ duration: 0.4, bounce: 0.15 }` |
| Streak ring completion | 600ms | `--ease-out-strong` |
| Modal overlay fade | 200ms | ease |

## Microinteractions

| Element | Behaviour |
|---|---|
| Any tappable element | `scale(0.97)` on active, 160ms ease-out |
| Checkbox complete | Caramel fill sweeps left to right (clip-path), 200ms linear |
| Task text on complete | Shifts to Stone + strikethrough, 150ms ease-out |
| Progress dot | Active dot 6px → 20px width, 200ms ease-out; previous shrinks simultaneously |
| Chip selection | Background fill to Caramel Light, 180ms ease-out |
| AI message entrance | Slides up 8px + fades in, 300ms `--ease-out-gentle` |

## `prefers-reduced-motion`

| Element | Reduced motion behaviour |
|---|---|
| All transform animations | Opacity fade only, 150ms ease |
| Mascot animations | Static image |
| Progress fills | Instant (no sweep) |
| AI typing indicator | All three dots opacity pulse simultaneously (no position movement) |

---

# 10. AI Experience Layer

## The Trust Design Problem

The core challenge: AI health advice for a pet carries real emotional weight. The visual layer must communicate: *"This analysis is thoughtful, grounded in your cat's specific context, and appropriately humble."* If the UI looks uncertain, users won't trust it. If it looks overconfident, users may ignore the vet when they should not.

## PurrCheck AI Visual Identity

**AI badge:** `PurrCheck AI` — Kenfolg SemiBold 11px, white on Lavender Deep `#8E7FCC`, radius 4px, padding 6px horizontal. Appears on every AI response card.

**Lavender as AI colour:** Throughout the product, lavender signals "this is the AI speaking" — the 3px left border on bubbles, the typing indicator dots, the badge, the quick-task selected state. Users learn this subconsciously.

## AI Response Anatomy

```
┌─────────────────────────────────────────────────────┐
│ [PurrCheck AI badge]   [Confidence: High ████░]      │
│                                                      │
│ Analysis Heading (Kenfolg H3, if structured)         │
│                                                      │
│ Response body in SF Pro Body M, Ink.                 │
│ Paragraphs at standard line spacing.                 │
│                                                      │
│ • Bullet recommendations                            │
│ • Second recommendation                             │
│ ─────────────────────────────────────────────────── │
│ ⓘ This is not veterinary advice. If symptoms        │
│   persist or worsen, please contact your vet.       │
└─────────────────────────────────────────────────────┘
```

## Confidence Indicator

```
High:      ████████░░  label "High"       — Wellness Green fill
Moderate:  █████░░░░░  label "Moderate"   — Alert Amber fill
Uncertain: ███░░░░░░░  label "Uncertain"  — Stone fill
```

Track: Lavender Light. Fill: Lavender Deep. When confidence is Uncertain, the response always ends with: *"For this I'd recommend booking a vet appointment."*

## Emergency State

When the AI detects a red-flag condition, the response card changes completely:

```
Left border:   4px solid #D94040
Background:    rgba(217,64,64,0.05)
Header:        "Contact your vet now" — Kenfolg H2, Urgent Red
Badge:         "URGENT" — white on #D94040
Body:          Clear, short sentences. No hedging.
Mascot:        Not present
PurrCheck AI badge:  Not present
```

The emergency state is the only moment the warm visual language is deliberately suspended. This contrast is what makes it feel urgent.

## AI Analysis Loading

1. Photo thumbnail appears in user bubble immediately
2. AI typing indicator within 200ms
3. Caption: *"PurrCheck is analysing [cat name]'s photo..."*
4. After 3 seconds: caption updates to *"This one takes a moment — looking carefully..."*
5. Response animates in via standard AI bubble entrance

---

# 11. Screenshot & Marketing Consistency

## App Store Screenshots

```
Background:   linear-gradient(180deg, #F2DFC0 0%, #FEFDFB 60%)
Device frame: iPhone 16 Pro
Headline:     Kenfolg Display L, Ink — above device
Subheadline:  SF Pro Body M, Stone — below headline
Device shadow: 0 40px 80px rgba(211,150,84,0.25)
```

**Screenshot sequence:**
1. Welcome — "Meet your cat's AI health companion"
2. AI chat with photo — "Show it. Don't describe it."
3. Daily task list — "Every day, taken care of."
4. Paywall — "7 days free. [Cat name]'s care, covered."
5. Health profile — "Their whole history. In your pocket."

## Social Creatives

- **Instagram post (1:1):** Mascot on lavender background, Kenfolg headline, caramel CTA
- **Story (9:16):** Full-bleed caramel-to-white gradient, centred mascot, minimal text
- **Motion ad:** Cinematic cold open → freeze frame → product reveal. The caramel brand colour is the transition signal between dramatic and warm product.

## Consistency Non-Negotiables

Across all surfaces:
- Kenfolg for every brand headline — never substitute SF Pro in marketing
- `#D39654` caramel as the single most recognisable colour
- 3D mascot is always the same model at the same quality level — no vector substitution
- PurrCheck AI badge uses identical treatment to in-app version

---

# 12. Competitive Positioning

## Visual Category

Catti competes in the intersection of three visual categories:

| Category | Examples | What Catti borrows |
|---|---|---|
| Consumer health apps | Headspace, Calm, Noom | Trust through clean layouts, warm colour, human copy |
| Pet care apps | Whistle, PetDesk, Rover | Pet-centric warmth, friendly UI |
| AI consumer products | Perplexity, Claude, ChatGPT mobile | Conversational hierarchy, trust through restraint |

Catti's visual position is **health app warmth + AI product precision + premium consumer finish.** It looks like none of the three individually.

## Why This Feels Modern in 2026

- **3D mascot quality** is the current premium signal — not flat vector, not pixel art, not stock photo
- **Floating pill navigation** has replaced full-width tab bars as the premium mobile pattern
- **Named AI identity** (PurrCheck, lavender system, confidence indicators) treats the AI as a real entity, not a loading spinner
- **Warm colour system** directly counters the cold blue/grey of first-generation AI products — the market has signalled that warmth wins in consumer AI

## Differentiators

- Personalisation from screen one — no competitor uses the cat's name at this depth
- Photo-first symptom assessment — every other pet health app is text-only Q&A
- The 3D orange tabby mascot is immediately ownable — no competitor has one at this quality
- Caramel + lavender palette does not exist in the pet health category

---

# 13. Implementation Guidance

## Design Tokens (CSS)

```css
/* === BRAND COLORS === */
--color-caramel:           #D39654;
--color-caramel-deep:      #B87A3A;
--color-caramel-light:     #F2DFC0;
--color-caramel-wash:      #FBF5EC;
--color-lavender:          #B8ACE5;
--color-lavender-deep:     #8E7FCC;
--color-lavender-light:    #DDD8F5;
--color-lavender-wash:     #F3F1FB;

/* === NEUTRALS === */
--color-ink:               #1A1611;
--color-charcoal:          #3D3529;
--color-stone:             #7A6E62;
--color-pebble:            #B5ADA4;
--color-mist:              #E8E3DC;
--color-cloud:             #F5F2EE;
--color-white:             #FEFDFB;

/* === SEMANTIC === */
--color-success:           #5BAD7F;
--color-warning:           #E8A020;
--color-danger:            #D94040;
--color-info:              #5B8DD9;

/* === RADIUS === */
--radius-xs:               6px;
--radius-sm:               10px;
--radius-md:               14px;
--radius-lg:               20px;
--radius-xl:               28px;
--radius-pill:             100px;

/* === SHADOWS === */
--shadow-card:             0 2px 12px rgba(26,22,17,0.07), 0 1px 3px rgba(26,22,17,0.04);
--shadow-sheet:            0 -8px 32px rgba(26,22,17,0.12);
--shadow-cta:              0 4px 16px rgba(211,150,84,0.35);
--shadow-float:            0 8px 32px rgba(26,22,17,0.12);

/* === SPACING === */
--space-2:  2px;   --space-4:  4px;   --space-8:   8px;
--space-12: 12px;  --space-16: 16px;  --space-20:  20px;
--space-24: 24px;  --space-32: 32px;  --space-40:  40px;
--space-48: 48px;  --space-64: 64px;

/* === TYPOGRAPHY === */
--font-brand:              'Kenfolg', system-ui;
--font-body:               -apple-system, 'SF Pro Text', system-ui;

/* === MOTION === */
--ease-out-strong:         cubic-bezier(0.23, 1, 0.32, 1);
--ease-in-out-smooth:      cubic-bezier(0.77, 0, 0.175, 1);
--ease-out-gentle:         cubic-bezier(0.34, 1.56, 0.64, 1);
--ease-drawer:             cubic-bezier(0.32, 0.72, 0, 1);
--duration-micro:          160ms;
--duration-fast:           220ms;
--duration-standard:       300ms;
--duration-slow:           380ms;
```

## Tailwind Configuration

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        caramel: {
          DEFAULT: '#D39654',
          deep:    '#B87A3A',
          light:   '#F2DFC0',
          wash:    '#FBF5EC',
        },
        lavender: {
          DEFAULT: '#B8ACE5',
          deep:    '#8E7FCC',
          light:   '#DDD8F5',
          wash:    '#F3F1FB',
        },
        ink:      '#1A1611',
        charcoal: '#3D3529',
        stone:    '#7A6E62',
        pebble:   '#B5ADA4',
        mist:     '#E8E3DC',
        cloud:    '#F5F2EE',
      },
      borderRadius: {
        xs:   '6px',
        sm:   '10px',
        md:   '14px',
        lg:   '20px',
        xl:   '28px',
        pill: '100px',
      },
      fontFamily: {
        brand: ['Kenfolg', 'system-ui'],
        body:  ['-apple-system', 'SF Pro Text', 'system-ui'],
      },
      boxShadow: {
        card:  '0 2px 12px rgba(26,22,17,0.07), 0 1px 3px rgba(26,22,17,0.04)',
        cta:   '0 4px 16px rgba(211,150,84,0.35)',
        sheet: '0 -8px 32px rgba(26,22,17,0.12)',
        float: '0 8px 32px rgba(26,22,17,0.12)',
      },
    },
  },
}
```

## Flutter / Dart Tokens

```dart
// colors.dart
const Color colorCaramel       = Color(0xFFD39654);
const Color colorCaramelDeep   = Color(0xFFB87A3A);
const Color colorCaramelLight  = Color(0xFFF2DFC0);
const Color colorLavender      = Color(0xFFB8ACE5);
const Color colorLavenderDeep  = Color(0xFF8E7FCC);
const Color colorInk           = Color(0xFF1A1611);
const Color colorStone         = Color(0xFF7A6E62);
const Color colorCloud         = Color(0xFFF5F2EE);
const Color colorWhite         = Color(0xFFFEFDFB);

// spacing.dart
const double space4  = 4.0;   const double space8  = 8.0;
const double space12 = 12.0;  const double space16 = 16.0;
const double space20 = 20.0;  const double space24 = 24.0;
const double space32 = 32.0;  const double space48 = 48.0;
```

## iOS-Specific Notes

- Use `cornerRadius` / `BorderRadius.circular()` consistently — never `RoundedRectangleBorder` with asymmetric radii unless intentional (chat bubbles)
- Bottom sheet: respect `MediaQuery.of(context).padding.bottom` for safe area
- Floating pill nav: position above safe area with `safeAreaInset(edge: .bottom)` wrapper — do not replace it
- Haptics: `UIImpactFeedbackGenerator(style: .light)` on checkbox complete; `.medium` on primary CTA; `.heavy` reserved for emergency state only (reinforces urgency through feel)
- Dynamic Type: allow SF Pro body text to scale; Kenfolg display text can be fixed size

## Accessibility Checklist

- [ ] All text-over-colour combinations pass 4.5:1 minimum (body) and 3:1 minimum (large/bold)
- [ ] All interactive elements minimum 44×44pt
- [ ] VoiceOver labels on mascot images: `"Catti mascot illustration"` — never empty alt
- [ ] `prefers-reduced-motion` handled for all animations
- [ ] Emergency state communicated by text AND colour — never colour alone
- [ ] Progress indicators announce percentage via `accessibilityValue`
- [ ] Confidence indicator reads as `"High confidence"` / `"Moderate confidence"` via accessibility label

---

*Design Language Document v1.0*
*Catti — Cat AI Health Assistant · Carrothon 2026 · Team C*
*Marco · Sveta · Dani · Kim · Hoang*
