import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model_jevon.dart';

class SeatControllerSalam with ChangeNotifier {
  final List<String> _selectedSeatsSalam = [];
  List<String> get selectedSeats => _selectedSeatsSalam;
  List<String> _soldSeatsSalam = [];
  List<String> get soldSeats => _soldSeatsSalam;

  int basePriceSalam = 0;
  String movieTitleSalam = "";

  StreamSubscription? _bookingSubscriptionSalam;

  void initData({
    required int basePriceInput,
    required String movieTitleInput,
  }) {
    basePriceSalam = basePriceInput;
    movieTitleSalam = movieTitleInput;
    _listenSoldSeatsSalam(movieTitleSalam);
  }

  void toggleSeat(String seat) {
    if (_selectedSeatsSalam.contains(seat)) {
      _selectedSeatsSalam.remove(seat);
    } else {
      _selectedSeatsSalam.add(seat);
    }
    notifyListeners();
  }

  int calculateTotalPrice() {
    int total = basePriceSalam * _selectedSeatsSalam.length;

    if (movieTitleSalam.length > 10) {
      total = total + (2500 * _selectedSeatsSalam.length);
    }

    for (var seat in _selectedSeatsSalam) {
      final number = int.tryParse(seat.substring(1)) ?? 0;
      if (number % 2 == 0) {
        total -= (basePriceSalam * 0.10).toInt();
      }
    }
    return total;
  }

  Future<void> loadSoldSeats(String movieTitle) async {
    final snapshot = await FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitle).get();
    _soldSeatsSalam = [];
    for (var doc in snapshot.docs) {
      List seats = doc['seats'];
      _soldSeatsSalam.addAll(seats.map((e) => e.toString()));
    }
    notifyListeners();
  }

  Future<String?> checkout(String userId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        return "Tidak ada koneksi internet. Silahkan cek jaringan Anda";
      }
    } catch (_) {
      return "Tidak ada koneksi internet. Silahkan cek jaringan Anda";
    }

    if (_selectedSeatsSalam.isEmpty || basePriceSalam == 0 || movieTitleSalam.isEmpty) {
      return "Data booking tidak lengkap";
    }

    final bookingCollection = FirebaseFirestore.instance.collection('bookings');
    final docRef = bookingCollection.doc();
    final bookingId = docRef.id;
    final data = {
      'booking_id': bookingId,
      'user_id': userId,
      'movie_title': movieTitleSalam,
      'seats': _selectedSeatsSalam,
      'total_price': calculateTotalPrice(),
      'booking_date': Timestamp.now(),
    };

    await docRef.set(data);
    await FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitleSalam).snapshots().first;
    _selectedSeatsSalam.clear();
    notifyListeners();
    return null;
  }

  void _listenSoldSeatsSalam(String movieTitle) {
    _bookingSubscriptionSalam?.cancel();
    _bookingSubscriptionSalam = FirebaseFirestore.instance.collection("bookings").where("movie_title", isEqualTo: movieTitle).snapshots().listen((snapshot) {
      Set<String> updateSoldSeats = {};
      for(var doc in snapshot.docs) {
        List seats = doc['seats'];
        updateSoldSeats.addAll(seats.map((e) => e.toString()));
      }
      _soldSeatsSalam = updateSoldSeats.toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _bookingSubscriptionSalam?.cancel();
    super.dispose();
  }
}
