class MovieModelJevon {
  final String id;
  final String title;
  final String poster;
  final int basePrice;
  final double rating;
  final int duration;

  MovieModelJevon({
    required this.id,
    required this.title,
    required this.poster,
    required this.basePrice,
    required this.rating,
    required this.duration,
  });

  factory MovieModelJevon.fromMapJevon(Map<String, dynamic> data, String docId) {
    return MovieModelJevon(
      id: docId,
      title: data['title'] ?? '',
      poster: data['poster'] ?? '',
      basePrice: (data['basePrice'] ?? 0).toInt(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      duration: (data['duration'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMapJevon() {
    return {
      'title': title,
      'poster': poster,
      'basePrice': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}