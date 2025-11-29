class MovieModelAdel {
  final String movieId;
  final String title;
  final String posterUrl;
  final int basePrice;
  final double rating;
  final int duration;

  MovieModelAdel({
    required this.movieId,
    required this.title,
    required this.posterUrl,
    required this.basePrice,
    required this.rating,
    required this.duration,
  });

  factory MovieModelAdel.fromMap(Map<String, dynamic> map) {
    return MovieModelAdel(
      movieId: map['movie id'] ?? '',
      title: map['title'] ?? '',
      posterUrl: map['poster url'] ?? '',
      basePrice: map['base price'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      duration: map['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movie id': movieId,
      'title': title,
      'poster url': posterUrl,
      'base price': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}
