import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModelJevon {
  final String booking_id;
  final String user_id;
  final String movie_title;
  final List<String> seats;
  final int total_price;
  final Timestamp booking_date;

  BookingModelJevon({
    required this.booking_id,
    required this.user_id,
    required this.movie_title,
    required this.seats,
    required this.total_price,
    required this.booking_date,
  });

  factory BookingModelJevon.fromMapJevon(Map<String, dynamic> data) {
    return BookingModelJevon(
      booking_id: data['booking_id'] ?? '',
      user_id: data['user_id'] ?? '',
      movie_title: data['movie_title'] ?? '',
      seats: List<String>.from(data['seats'] ?? []),
      total_price: (data['total_price'] ?? 0).toInt(),
      booking_date: data['booking_date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMapJevon() {
    return {
      'booking_id': booking_id,
      'user_id': user_id,
      'movie_title': movie_title,
      'seats': seats,
      'total_price': total_price,
      'booking_date': booking_date,
    };
  }
}