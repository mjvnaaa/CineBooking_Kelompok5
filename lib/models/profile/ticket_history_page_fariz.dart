import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../home/home_page_adel.dart';
//import '../../models/ticket/ticket_provider_fariz.dart';
import '../../models/ticket/ticket_model_fariz.dart';

class ProfilePageFariz extends StatelessWidget {
  const ProfilePageFariz({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    //final ticketProvider = context.watch<TicketProviderFariz>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F29),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePageAdel()),
            );
          },
        ),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final username = userData['username'] ?? 'User';
          final email = user.email ?? 'email@example.com';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // User info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber.shade600,
                      child: const Icon(Icons.person, color: Colors.black, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ticket History",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Ticket history
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('bookings')
                        .where('user_id', isEqualTo: user.uid)
                        .orderBy('booking_date', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final ticketDocs = snapshot.data!.docs;
                      if (ticketDocs.isEmpty) {
                        return Center(
                          child: Text(
                            "No tickets booked yet.",
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        );
                      }

                      // Update provider
                      final tickets = ticketDocs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return TicketFariz(
                          movie: data['movie_title'],
                          seats: List<String>.from(data['seats']),
                          date: (data['booking_date'] as Timestamp).toDate(),
                          bookingId: data['booking_id'],
                          totalPrice: data['total_price'],
                        );
                      }).toList();

                      return ListView.builder(
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1F29),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket.movie,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Seats: ${ticket.seats.join(', ')}',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Date: ${ticket.date}',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                                Center(
                                  child: QrImageView(
                                    data: ticket.bookingId,
                                    version: QrVersions.auto,
                                    size: 120,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    'Booking ID: ${ticket.bookingId}',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}