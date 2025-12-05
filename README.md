# **PRESENTASI BACKEND ENGINEER - ANGGOTA 1: JEVON**

Selamat pagi, Bapak/Ibu Dosen. Saya **Jevon**, bertanggung jawab sebagai **Backend Engineer** dalam proyek CineBooking ini. Saya akan menjelaskan secara detail implementasi backend yang saya buat.

## **1. ROLE DAN TANGGUNG JAWAB SAYA**

Sebagai Backend Engineer, saya memiliki 3 tugas utama sesuai spesifikasi proyek:

1. **Setup Firebase** (Authentication + Firestore Database)
2. **Membuat Class Model Data** dengan implementasi manual `fromMap` dan `toMap`
3. **Data Seeding** - menginput minimal 10 film dengan variasi panjang judul untuk testing Logic Trap

## **2. ARSITEKTUR FIREBASE YANG SAYA SETUP**

### **2.1 Konfigurasi Firebase (`firebase_options.dart`)**

```dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(...);
      default:
        throw UnsupportedError(...);
    }
  }
  
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAH-MT0YE1rP31_AzkevYJHERsAcMQxNXw',
    appId: '1:224634000410:web:81dec757143910d68cada3',
    messagingSenderId: '224634000410',
    projectId: 'cinebooking-tim5',
    authDomain: 'cinebooking-tim5.firebaseapp.com',
    storageBucket: 'cinebooking-tim5.firebasestorage.app',
    measurementId: 'G-4NTC30QFKQ',
  );
  
  // Konfigurasi serupa untuk platform lain...
}
```

**Penjelasan implementasi:**
1. **File ini dibuat menggunakan FlutterFire CLI** dengan perintah `flutterfire configure`
2. **Multi-platform support**: Saya mengkonfigurasi untuk 6 platform berbeda (Web, Android, iOS, macOS, Windows, Linux)
3. **Security**: API key dan App ID di-generate secara otomatis oleh Firebase
4. **Project ID**: `cinebooking-tim5` adalah project Firebase yang saya buat khusus untuk tim kami
5. **Setiap platform memiliki konfigurasi unik** karena Firebase memerlukan setup yang berbeda per platform

### **2.2 Inisialisasi Firebase di Main App (`main.dart`)**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketProviderFariz()),
        ChangeNotifierProvider(create: (_) => SeatControllerSalam()),
      ],
      child: const MyApp(),
    ),
  );
}
```

**Penjelasan implementasi:**
1. **`WidgetsFlutterBinding.ensureInitialized()`**: Wajib dipanggil sebelum menggunakan plugin Flutter
2. **`Firebase.initializeApp()`**: Menginisialisasi Firebase dengan konfigurasi yang sesuai untuk platform yang sedang berjalan
3. **State Management Setup**: Saya setup Provider untuk state management yang akan digunakan di seluruh aplikasi

## **3. IMPLEMENTASI MODEL DATA (CORE BACKEND)**

### **3.1 MovieModelJevon (`movie_model_jevon.dart`)**

```dart
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
```

**Penjelasan implementasi:**
1. **Mengikuti spesifikasi database**: Field-field sesuai dengan spesifikasi (title, poster, basePrice, rating, duration)
2. **Manual fromMap/toMap**: Saya implementasi secara manual, tidak menggunakan generator code
3. **Null safety handling**: Menggunakan operator `??` untuk memberikan default value jika data null
4. **Type conversion**: Explicit conversion dengan `.toInt()` dan `.toDouble()` untuk memastikan tipe data sesuai
5. **Inisial pencipta**: Fungsi `fromMapJevon` dan `toMapJevon` menggunakan inisial saya (Jevon)
6. **Document ID handling**: Parameter `docId` digunakan sebagai primary key dari Firestore

### **3.2 UserModelJevon (`user_model_jevon.dart`)**

```dart
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
```

**Penjelasan implementasi:**
1. **Mengikuti spesifikasi users collection**: uid, email, username, balance
2. **Primary Key**: `uid` berasal dari Firebase Authentication
3. **Balance default**: `0` sesuai spesifikasi
4. **Manual serialization**: Both `toMapJevon` dan `fromMapJevon` diimplementasi manual
5. **Consistency**: Pattern yang sama dengan MovieModel untuk konsistensi kode

## **4. IMPLEMENTASI CONTROLLER (BUSINESS LOGIC)**

### **4.1 SeatControllerSalam (`seat_controller.dart`)**

**Note**: Meskipun controller ini dibuat oleh anggota 4 (Salam), sebagai backend engineer saya perlu memahami dan menjelaskan logika bisnis yang berkaitan dengan data.

```dart
class SeatControllerSalam with ChangeNotifier {
  final List<String> _selectedSeats = [];
  List<String> get selectedSeats => _selectedSeats;
  List<String> _soldSeats = [];
  List<String> get soldSeats => _soldSeats;

  int basePrice = 0;
  String movieTitle = "";
```

**Penjelasan:**
1. **State Management**: Menggunakan `ChangeNotifier` untuk reactive programming
2. **Private variables**: `_selectedSeats` dan `_soldSeats` adalah private dengan public getter
3. **Data storage**: Menyimpan `basePrice` dan `movieTitle` untuk perhitungan harga

```dart
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
```

**IMPLEMENTASI LOGIC TRAP (CRITICAL BUSINESS LOGIC):**

1. **"Long Title" Tax**:
   ```dart
   if (movieTitle.length > 10) {
     total = total + (total * 0.05).toInt();
   }
   ```
   - **Logika**: Jika judul film > 10 karakter, tambah 5% dari total harga
   - **Perbedaan dengan spesifikasi**: Spesifikasi minta Rp 2.500 per kursi, tetapi implementasi ini menggunakan 5% (mungkin perlu diklarifikasi)

2. **Odd/Even Seat Rule**:
   ```dart
   final number = int.tryParse(seat.substring(1)) ?? 0;
   if (number % 2 == 0) {
     total -= (basePrice * 0.10).toInt();
   }
   ```
   - **Parsing seat number**: `"A2".substring(1)` = `"2"` → parsing ke integer
   - **Diskon 10%**: Untuk kursi genap, kurangi 10% dari harga dasar per kursi
   - **Null safety**: `int.tryParse()` dengan fallback `0` jika parsing gagal

```dart
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
```

**IMPLEMENTASI DATABASE OPERATIONS:**

1. **Validation**: Cek data lengkap sebelum proses booking
2. **Auto-generate ID**: `bookingCollection.doc()` membuat document dengan ID otomatis
3. **Data structure**: Mengikuti spesifikasi dengan field: booking_id, user_id, movie_title, seats, total_price, booking_date
4. **Real-time sync**: Setelah save, trigger snapshot untuk update sold seats
5. **Cleanup**: Clear selected seats setelah booking berhasil

```dart
  void _listenSoldSeats(String movieTitle) {
    _bookingSubscription?.cancel();

    _bookingSubscription = FirebaseFirestore.instance
        .collection("bookings")
        .where("movie_title", isEqualTo: movieTitle)
        .snapshots()
        .listen((snapshot) {
      Set<String> updateSoldSeats = {};
      for(var doc in snapshot.docs) {
        List seats = doc['seats'];
        updateSoldSeats.addAll(seats.map((e) => e.toString()));
      }
      _soldSeats = updateSoldSeats.toList();
      notifyListeners();
    });
  }
```

**REAL-TIME UPDATES IMPLEMENTATION:**

1. **Stream Subscription**: Menggunakan `StreamSubscription` untuk real-time updates
2. **Query filtering**: `where("movie_title", isEqualTo: movieTitle)` untuk filter per film
3. **Data aggregation**: Mengumpulkan semua sold seats dari berbagai booking
4. **Set untuk uniqueness**: Menggunakan `Set` untuk menghindari duplikasi
5. **Automatic updates**: Setiap ada perubahan di Firestore, UI akan otomatis update

## **5. IMPLEMENTASI AUTHENTICATION & DATABASE OPERATIONS**

### **5.1 Registration dengan Database Write (`register_page_fariz.dart`)**

```dart
UserCredential userCredentialFariz = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: emailFariz, password: passwordFariz);

String uidFariz = userCredentialFariz.user!.uid;

await FirebaseFirestore.instance.collection('users').doc(uidFariz).set({
  'uid': uidFariz,
  'email': emailFariz,
  'username': usernameFariz,
  'balance': 0,
  'createdAt': Timestamp.now(),
  'inisial_fariz': true,
});
```

**Backend implementation details:**
1. **Two-step process**: 
   - Step 1: Create user di Firebase Authentication
   - Step 2: Create document di Firestore collection 'users'
2. **Consistent ID**: Menggunakan `uid` dari Authentication sebagai document ID di Firestore
3. **Default values**: `balance: 0` sesuai spesifikasi
4. **Timestamp**: `createdAt` menggunakan server timestamp
5. **Additional field**: `inisial_fariz` untuk memenuhi requirement inisial pencipta

### **5.2 Ticket History dengan Database Read (`ticket_history_page_fariz.dart`)**

```dart
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('bookings')
      .where('user_id', isEqualTo: user.uid)
      .orderBy('booking_date', descending: true)
      .snapshots(),
  builder: (context, snapshot) {
    // Processing logic...
  }
)
```

**Database query implementation:**
1. **Filter by user**: `where('user_id', isEqualTo: user.uid)` untuk mendapatkan booking user saat ini
2. **Sorting**: `orderBy('booking_date', descending: true)` untuk menampilkan terbaru pertama
3. **Real-time**: `.snapshots()` untuk real-time updates
4. **Data mapping**: Convert Firestore documents ke `TicketFariz` model

## **6. DATA SEEDING IMPLEMENTATION**

Sebagai Backend Engineer, saya melakukan data seeding melalui Firebase Console dengan 10 film:

**Contoh data yang saya input:**
1. **Film pendek (<10 karakter)**: 
   - "Avengers" (8 karakter) - harga normal
   - "Titanic" (7 karakter) - harga normal
   
2. **Film panjang (>10 karakter)**:
   - "Spider-Man: No Way Home" (21 karakter) - kena pajak 5%
   - "The Lord of the Rings: The Return of the King" (45 karakter) - kena pajak 5%

**Struktur data yang di-seed:**
```json
{
  "title": "Spider-Man: No Way Home",
  "poster": "https://example.com/poster.jpg",
  "basePrice": 50000,
  "rating": 4.8,
  "duration": 148
}
```

## **7. IMPLEMENTASI BUSINESS RULES VALIDATION**

### **Testing Scenario Implementation:**

1. **Tes Trap Judul**:
   - Avengers (8 huruf): `50000 * 2 = 100000` (tidak kena pajak)
   - Spider-Man (21 huruf): `50000 * 2 = 100000 + 5% = 105000`

2. **Tes Trap Kursi**:
   - Kursi A1 (ganjil): Harga normal 50000
   - Kursi A2 (genap): Diskon 10% = 45000
   - **Total**: `50000 + 45000 = 95000` (bukan 100000)

3. **Error Handling**:
   ```dart
   if (_selectedSeats.isEmpty || basePrice == 0 || movieTitle.isEmpty) {
     throw Exception("Data booking tidak lengkap");
   }
   ```

## **8. KESIMPULAN IMPLEMENTASI BACKEND**

**Achievements:**
1. **Firebase Setup**: Multi-platform configuration selesai
2. **Model Classes**: `MovieModelJevon` dan `UserModelJevon` dengan manual serialization
3. **Database Schema**: Mengikuti spesifikasi dengan tepat
4. **Business Logic**: Logic Trap diimplementasi secara manual
5. **Data Seeding**: 10+ film dengan variasi panjang judul
6. **Error Handling**: Validasi input dan error handling
7. **Real-time Updates**: Live seat availability tracking
8. **Security Rules**: (Di Firebase Console) mengatur read/write permissions

**Technical Decisions:**
1. **Firestore over Realtime Database**: Dipilih karena struktur data yang kompleks
2. **Manual Model Mapping**: Untuk full control tanpa dependency library
3. **Stream-based Architecture**: Untuk real-time updates
4. **Provider State Management**: Simple dan efektif untuk skala proyek ini

**Challenges & Solutions:**
1. **Challenge**: Implementasi Logic Trap yang sesuai spesifikasi
   **Solution**: Manual calculation dengan parsing seat numbers
2. **Challenge**: Real-time seat availability
   **Solution**: Stream subscription dengan query filtering
3. **Challenge**: Data consistency antara Auth dan Firestore
   **Solution**: Using UID sebagai primary key yang konsisten

Terima kasih, Bapak/Ibu Dosen. Saya siap untuk pertanyaan lebih lanjut mengenai implementasi backend kami.