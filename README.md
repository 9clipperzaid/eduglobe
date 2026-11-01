# 🎓 EduGlobe — Global Education & Study-Abroad App

A Flutter mobile application prototype developed for the **Flutter Developer Intern Assignment**. Features a complete 4-screen flow, cohesive modern blue design system, custom vector logo & illustrations, form validations, and local state persistence.

---

## 📱 App Flow & Architecture

The app adheres strictly to the required launch-state routing and navigation lifecycle:

```
Splash Screen ──► Onboarding Screen ──► Login Screen ──► Home Screen
     ▲                                                         │
     │                                                         ▼
     └────────────────── Logout ◄──────────────────────────────┘
```

### 🧭 Navigation Lifecycle & State Persistence
- **First Launch**: `Splash` ➔ `Onboarding` ➔ `Login` ➔ `Home`.
- **Subsequent Launches (Onboarding completed, not logged in)**: `Splash` ➔ `Login`.
- **Subsequent Launches (Already logged in)**: `Splash` ➔ `Home`.
- **Logout Action**: Clears the session credentials/login flag while preserving the onboarding flag, safely redirecting to `Login`.

---

## ✨ Implemented Features & Screens

### 1. 🌟 Splash Screen (`lib/screens/splash_screen.dart`)
- **Branding**: Custom-designed vector logo featuring a globe, academic mortarboard with gold tassel, and dynamic orbital ring created using `CustomPainter`.
- **Visual Design**: High-contrast, deep navy-to-royal-blue gradient with luminous background aura rings and subtle wave curves.
- **Auto-Routing**: Checks `SharedPreferences` asynchronously (~2.2s delay) and routes the user based on persistent local state.

### 2. 🚀 Onboarding Screen (`lib/screens/onboarding_screen.dart`)
- **Interactive Slides**: 3 swipeable slides powered by `PageView`:
  1. *Explore Universities* — Global reach, rankings & programs.
  2. *Find the Right Course* — Eligibility, fees, and scholarship opportunities.
  3. *Plan Your Journey* — Step-by-step visa assistance and arrival prep.
- **Controls**: Custom animated pill/dot indicators, **Skip** (header action), **Next**, and final **Get Started** button.
- **Persistence**: Marks `onboarding_completed` flag locally so it is never repeated.

### 3. 🔐 Login Screen (`lib/screens/login_screen.dart`)
- **Branding**: Clean EduGlobe logo header with welcome greeting.
- **Validation**:
  - Email format validation using regular expressions.
  - Password required validation with minimum length constraint.
  - Interactive password visibility toggle (Show/Hide).
- **Demo Access**: One-tap **Auto-fill** button for evaluator testing without manual typing.
- **Session Persistence**: Stores login state and user profile information via `SharedPreferences`.

### 4. 🏛️ Home Screen (`lib/screens/home_screen.dart`)
- **Student Profile**: Dynamic greeting (*"Hello, Alex 👋"*), user initial avatar, and notification badge.
- **Hero Explore Banner**: High-impact gradient card for 2026/2027 admissions with call-to-action.
- **Popular Study Destinations**: Horizontal card carousel (🇬🇧 UK, 🇺🇸 USA, 🇨🇦 Canada, 🇦🇺 Australia, 🇩🇪 Germany).
- **Category Filter**: Interactive category chips (*All, Engineering, Business, Medicine, Computer Science*).
- **Featured University Cards**:
  - Sample universities: University of Oxford, MIT, University of Toronto, University of Melbourne.
  - Key metrics: Global Rank badge, Acceptance Rate, Estimated Tuition.
  - Tap-to-view interactive details modal bottom-sheet.
- **Navigation & Logout**: Bottom navigation bar (Home, Explore, Profile) with confirmation dialog for signing out.

---

## 🔑 Demo Credentials

Evaluators can either tap the **"Auto-fill"** button on the Login screen or use the following credentials:

| Field | Value |
| :--- | :--- |
| **Email** | `alex.student@eduglobe.com` |
| **Password** | `Password123` |

*(Any valid email format and password with ≥6 characters will also pass validation).*

---

## 🛠️ Tech Stack & Requirements

- **Framework**: Flutter 3.44.0 (Channel stable)
- **Language**: Dart 3.12.0
- **State & Storage**: `shared_preferences: ^2.5.6`
- **Icons**: Material Icons & Cupertino Icons
- **Design System**: Custom Material 3 theme (`lib/app/app_theme.dart`) with Royal Blue palette (`#0F2B66`, `#1D4ED8`, `#38BDF8`).

---

## 📁 Project Structure

```
lib/
├── app/
│   └── app_theme.dart             # Palette, gradients, button & input styles
├── models/
│   ├── onboarding_item.dart       # Onboarding slides data model
│   └── university.dart            # University & destination models
├── screens/
│   ├── home_screen.dart           # Home screen with banners, cards & navigation
│   ├── login_screen.dart          # Form validation, show/hide, demo autofill
│   ├── onboarding_screen.dart     # Swipeable PageView with animated indicators
│   └── splash_screen.dart         # Custom logo, animations & state routing
├── services/
│   └── local_storage_service.dart # SharedPreferences wrapper for session & state
├── widgets/
│   ├── app_logo.dart              # CustomPainter vector logo & typography
│   ├── primary_button.dart        # Reusable button with gradients & loading state
│   └── university_card.dart       # Modular card with ranking tags & modal sheet
└── main.dart                      # App entrypoint and named routes setup
```

---

## 🚀 Setup & Installation Instructions

### 1. Clone the repository
```bash
git clone https://github.com/9clipperzaid/eduglobe.git
cd eduglobe
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run static analysis & tests
```bash
flutter analyze
flutter test
```

### 4. Run the app
```bash
flutter run
```

---

## 📄 Evaluation Rubric Alignment

- **UI Design & Consistency**: Unified blue aesthetic, typography hierarchy, responsive spacing, and custom vector logo without missing asset dependencies.
- **Navigation Flow**: Clean lifecycle routing via named routes, prevention of duplicate back-stack entries.
- **Flutter Fundamentals**: Clean state management, proper widget tree breakdown, single responsibility principle.
- **Validation & Persistence**: Robust email/password regex validation and reliable SharedPreferences session tracking.
