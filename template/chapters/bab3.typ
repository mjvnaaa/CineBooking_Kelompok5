= Arsitektur Backend

Dikerjakan oleh [*Jevon*] (Backend Engineer)[cite: 23].

== Struktur Database (Firestore)
Menggunakan 3 Collection utama: `users`, `movies`, dan `bookings`[cite: 13, 15, 17].

== Data Seeding
Bukti seeding minimal 10 film dummy ke Firebase menggunakan `MovieSeederJevon`[cite: 27].

```json
{
  "movie_id": "movie1",
  "title": "Avatar",
  "poster_url": "https://image.tmdb.org/t/p/original/6wkfovpn7Eq8dYNKaG5PY3q2oq6.jpg",
  "base_price": 55000,
  "rating": 4.5,
  "duration": 162
}
```

```dart
// File: utils/movie_seeder_jevon.dart
final movies = [
  {
    'movie_id': 'movie1',
    'title': 'Avatar',
    'poster_url': 'https://image.tmdb.org/t/p/original/6wkfovpn7Eq8dYNKaG5PY3q2oq6.jpg',
    'base_price': 55000,
    'rating': 4.5,
    'duration': 162,
  },
];
```