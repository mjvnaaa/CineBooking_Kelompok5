import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeatControllerSalam with ChangeNotifier {
  final List<String> _selectedSeats = [];
  List<String> get selectedSeats => _selectedSeats;
  List<String> _soldSeats = [];
  List<String> get soldSeats => _soldSeats;

  int basePrice = 0;
  String movieTitle = "";

  StreamSubscription? _bookingSubscription;

  void initData({
    required int basePriceInput,
    required String movieTitleInput,
  }) {
    basePrice = basePriceInput;
    movieTitle = movieTitleInput;

    _listenSoldSeats(movieTitle);
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

  Future<void> loadSoldSeats(String movieTitle) async {
    final snapshot = await FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitle).get();
    _soldSeats = [];

    for (var doc in snapshot.docs) {
      List seats = doc['seats'];
      _soldSeats.addAll(seats.map((e) => e.toString()));
    }

    notifyListeners();
  }

  Future<void> checkout(String userId) async {
    if (_selectedSeats.isEmpty || basePrice == 0 || movieTitle.isEmpty) {
      throw Exception("Data booking tidak lengkap");
    }

    final bookingCollection = FirebaseFirestore.instance.collection('bookings');
    final docRef = bookingCollection.doc();
    final bookingId = docRef.id;
    final data = {
      'booking_id': bookingId,
      'user_id': userId,
      'movie_title': movieTitle,
      'seats': _selectedSeats,
      'total_price': calculateTotalPrice(),
      'booking_date': Timestamp.now(),
    };

    await docRef.set(data);
    await FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitle).snapshots().first;
    _selectedSeats.clear();
    notifyListeners();
  }

  void _listenSoldSeats(String movieTitle) {
    _bookingSubscription?.cancel();

    _bookingSubscription = FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitle).snapshots().listen((snapshot) {
      Set<String> updateSoldSeats = {};
      for(var doc in snapshot.docs) {
        List seats = doc['seats'];
        updateSoldSeats.addAll(seats.map((e) => e.toString()));
      }
      _soldSeats = updateSoldSeats.toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _bookingSubscription?.cancel();
    super.dispose();
  }
}