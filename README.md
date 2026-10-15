# fitness_tracker

A modern fitness-tracking app built with Flutter using **MVVM** architecture,
with a social **friends activity** feed — styled in a **neo-brutalist** design
system: paper canvas, thick black outlines, hard offset shadows, an acid-lime
accent and chunky type.

## Features

- **Home** — greeting, a staggered summary grid (Activity steps, Distance,
  Weekly goal with a 7-day sparkline, Calories), and recent activities with
  All / Morning / Recovery filters.
- **Statistics** — a "Weekly goal" bar chart (last 7 days), an Intensity card
  with a warm glow, weekly step/active-time totals and a weather card.
- **Friends** — a ranked friends-activity list showing each friend's activity
  and change, with Applaud (togglable) and Message actions.
- **Profile** — athlete summary (day streak, total steps, workouts, distance)
  and a settings list.
- **Log activity** — the floating **+** action opens a form (type, title,
  duration, distance, steps, calories) with validation.
- **All activities** — full list from "See all", swipe-to-delete.

## Architecture (MVVM)

```
lib/
  main.dart                     # Provides the repository + MaterialApp
  core/
    theme/                      # AppColors, AppTheme (design tokens)
    utils/formatters.dart       # Steps / distance / duration / date helpers
  data/
    models/                     # Activity, ActivityType, Friend, Weather
    repositories/               # FitnessRepository (ChangeNotifier store)
  viewmodels/                   # Home, Stats, Friends, Profile, AddActivity,
                                # Activities (share a ViewModel base)
  navigation/                   # AppRoutes
  views/
    screens/                    # Thin screens; compose feature widgets
    widgets/
      common/                   # AmbientBackground, GlassCard, StatCard,
                                # PillTabBar, BarChart, ProgressBar, …
      home/ stats/ friends/ navigation/
```

- **Model** — `FitnessRepository` is an in-memory `ChangeNotifier` seeded with
  ~14 days of activities, friends and weather.
- **ViewModel** — each screen has a ViewModel extending a shared `ViewModel`
  base that subscribes to the repository, so every screen stays in sync.
- **View** — thin screens that read their ViewModel via `provider`
  (`context.watch`) and delegate to small, feature-grouped widgets.

## Design

- Neo-brutalist design system: paper canvas with a faint dot grid, 2.5px black
  outlines, blur-less hard offset shadows and an acid-lime accent.
- Reusable `NeoCard` surfaces with a press-in animation, used for the nav bar
  and every card.
- Custom-drawn outlined bar chart (no chart dependencies); only `provider`
  is added.

## Getting started

```bash
flutter pub get
flutter run
```

## Quality checks

```bash
flutter analyze   # 0 issues
flutter test      # 10 tests
```
