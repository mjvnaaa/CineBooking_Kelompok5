import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelJevon {
  final String uid;
  final String email;
  final String username;
  final int balance;
  final Timestamp created_at;

  UserModelJevon({
    required this.uid,
    required this.email,
    required this.username,
    required this.balance,
    required this.created_at,
  });

  Map<String, dynamic> toMapJevon() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'balance': balance,
      'created_at': created_at,
    };
  }

  factory UserModelJevon.fromMapJevon(Map<String, dynamic> map) {
    return UserModelJevon(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      balance: (map['balance'] ?? 0).toInt(),
      created_at: map['created_at'] ?? Timestamp.now(),
    );
  }
}
