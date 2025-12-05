import 'package:cloud_firestore/cloud_firestore.dart';

class MovieSeederJevon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seedMovies() async {
    try {
      final movies = [
        {
          'movie_id': 'movie1',
          'title': 'Avatar',
          'poster_url': 'https://image.tmdb.org/t/p/original/6wkfovpn7Eq8dYNKaG5PY3q2oq6.jpg',
          'base_price': 55000,
          'rating': 4.5,
          'duration': 162,
        },
        {
          'movie_id': 'movie2',
          'title': 'Titanic',
          'poster_url': 'https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg',
          'base_price': 50000,
          'rating': 4.7,
          'duration': 195,
        },
        {
          'movie_id': 'movie3',
          'title': 'Spider-Man: No Way Home',
          'poster_url': 'https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
          'base_price': 60000,
          'rating': 4.8,
          'duration': 148,
        },
        {
          'movie_id': 'movie4',
          'title': 'The Batman',
          'poster_url': 'https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg',
          'base_price': 58000,
          'rating': 4.3,
          'duration': 176,
        },
        {
          'movie_id': 'movie5',
          'title': 'Avengers: Endgame',
          'poster_url': 'https://image.tmdb.org/t/p/original/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
          'base_price': 65000,
          'rating': 4.9,
          'duration': 181,
        },
        {
          'movie_id': 'movie6',
          'title': 'Dune',
          'poster_url': 'https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
          'base_price': 62000,
          'rating': 4.2,
          'duration': 155,
        },
        {
          'movie_id': 'movie7',
          'title': 'No Time To Die',
          'poster_url': 'https://image.tmdb.org/t/p/original/iUgygt3fscRoKWCV1d0C7FbM9TP.jpg',
          'base_price': 57000,
          'rating': 4.1,
          'duration': 163,
        },
        {
          'movie_id': 'movie8',
          'title': 'The Matrix Resurrections',
          'poster_url': 'https://image.tmdb.org/t/p/original/8c4a8kE7PizaGQQnditMmI1xbRp.jpg',
          'base_price': 59000,
          'rating': 3.9,
          'duration': 148,
        },
        {
          'movie_id': 'movie9',
          'title': 'Eternals',
          'poster_url': 'https://image.tmdb.org/t/p/original/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg',
          'base_price': 56000,
          'rating': 3.8,
          'duration': 157,
        },
        {
          'movie_id': 'movie10',
          'title': 'Shang-Chi',
          'poster_url': 'https://image.tmdb.org/t/p/original/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg',
          'base_price': 58000,
          'rating': 4.0,
          'duration': 132,
        },
      ];

      for (var movie in movies) {
        await _firestore
            .collection('movies')
            .doc(movie['movie_id'] as String)
            .set(movie);
      }

    } catch (e) {
      print('Error seeding movies: $e');
    }
  }

  Future<void> _clearMovies() async {
    final snapshot = await _firestore.collection('movies').get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updateExistingMovies() async {
    try {
      final snapshot = await _firestore.collection('movies').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();

        final updatedData = {
          'movie_id': doc.id,
          'title': data['title'] ?? '',
          'poster_url': data['poster'] ?? data['poster_url'] ?? '',
          'base_price': data['basePrice'] ?? data['base_price'] ?? 0,
          'rating': data['rating'] ?? 0.0,
          'duration': data['duration'] ?? 0,
        };

        await doc.reference.update(updatedData);
      }

    } catch (e) {
      print('Error updating movies: $e');
    }
  }
}