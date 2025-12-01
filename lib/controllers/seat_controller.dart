import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeatControllerSalam with ChangeNotifier {
  final List<String> _selectedSeats = [];
  List<String> get selectedSeats => _selectedSeats;

  int basePrice = 0;
  String movieTitle = "";

  void initData({
    required int basePriceInput,
    required String movieTitleInput,
  }) {
    basePrice = basePriceInput;
    movieTitle = movieTitleInput;
  }

  void toggleSeat(String seat) {
    if (_selectedSeats.contains(seat)) {
      _selectedSeats.remove(seat);
    } else {
      _selectedSeats.add(seat);
    }
    notifyListeners();
  }

  int calculateTotalPrice() {
    int total = basePrice * _selectedSeats.length;

    if (movieTitle.length > 10) {
      total = total + (total * 0.05).toInt();
    }

    for (var seat in _selectedSeats) {
      final number = int.tryParse(seat.substring(1)) ?? 0;
      if (number % 2 == 0) {
        total -= (basePrice * 0.10).toInt();
      }
    }
    return total;
  }

  Future<void> checkout(String userId) async {
    final total = calculateTotalPrice();
    await FirebaseFirestore.instance.collection("bookings").add({
      "booking_id": 1,
      "user_id": userId,
      "movie_title": movieTitle,
      "seats": _selectedSeats,
      "total_price": total,
      "booking_date": DateTime.now(),
    });
  }
}