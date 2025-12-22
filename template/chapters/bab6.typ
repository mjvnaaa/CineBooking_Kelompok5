= Integrasi & Git Branching

== Struktur Git Branch
```
main
├── feature/backend-jevon
├── feature/ui-home-adel
├── feature/ui-seat-intan
├── feature/logic-salam
└── feature/auth-profile-fariz
```

== Integrasi Provider di Main App
```dart
// File: main.dart
runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TicketProviderFariz()),
      ChangeNotifierProvider(create: (_) => SeatControllerSalam()),
    ],
    child: const MyApp(),
  )
);
```

== Routing Antara Modul
```dart
// Dari home ke detail film
Navigator.push(context, MaterialPageRoute(
  builder: (_) => MovieDetailPageAdel(movie: movies[i])));

// Dari detail ke seat selection
Navigator.push(context, MaterialPageRoute(
  builder: (context) => SeatPageIntan(
    movieTitleIntan: movie.title,
    basePriceIntan: movie.base_price,
  )));
```