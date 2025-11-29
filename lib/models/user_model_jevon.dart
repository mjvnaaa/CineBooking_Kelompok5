class UserModelJevon {
  final String uid;
  final String email;
  final String username;
  final int balance;

  UserModelJevon({
    required this.uid,
    required this.email,
    required this.username,
    required this.balance,
  });

  Map<String, dynamic> toMapJevon() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'balance': balance,
    };
  }

  factory UserModelJevon.fromMapJevon(Map<String, dynamic> map) {
    return UserModelJevon(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      balance: (map['balance'] ?? 0).toInt(),
    );
  }
}