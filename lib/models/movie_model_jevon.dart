class MovieModelJevon {
  final String id;
  final String movie_id;
  final String title;
  final String poster_url;
  final int base_price;
  final double rating;
  final int duration;

  MovieModelJevon({
    required this.id,
    required this.movie_id,
    required this.title,
    required this.poster_url,
    required this.base_price,
    required this.rating,
    required this.duration,
  });

  factory MovieModelJevon.fromMapJevon(Map<String, dynamic> data, String docId) {
    return MovieModelJevon(
      id: docId,
      movie_id: data['movie_id'] ?? docId,
      title: data['title'] ?? '',
      poster_url: data['poster_url'] ?? '',
      base_price: (data['base_price'] ?? 0).toInt(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      duration: (data['duration'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMapJevon() {
    return {
      'movie_id': movie_id,
      'title': title,
      'poster_url': poster_url,
      'base_price': base_price,
      'rating': rating,
      'duration': duration,
    };
  }
}