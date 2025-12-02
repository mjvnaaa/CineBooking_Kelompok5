import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePageFariz extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfilePageFariz({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  final List<Map<String, String>> tickets = const [
    {
      'movie': 'Avatar: The Way of Water',
      'studio': 'Studio 1',
      'seat': 'A5',
      'date': '2025-12-03 19:30',
      'bookingId': 'BK202512030001'
    },
    {
      'movie': 'Spider-Man: No Way Home',
      'studio': 'Studio 3',
      'seat': 'C12',
      'date': '2025-12-01 21:00',
      'bookingId': 'BK202512010024'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F29),
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile info
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
                      userName,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),

            // Ticket history
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ticket History",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
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
                          ticket['movie'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Studio: ${ticket['studio']} | Seat: ${ticket['seat']}',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Date: ${ticket['date']}',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: QrImageView(
                            data: ticket['bookingId'] ?? '',
                            version: QrVersions.auto,
                            size: 120,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Booking ID: ${ticket['bookingId']}',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}