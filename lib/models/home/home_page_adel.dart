// lib/models/home/home_page_adel.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../movie_model_jevon.dart'; 
import 'movie_card_adel.dart';
import 'movie_detail_page_adel.dart';

class HomePageAdel extends StatelessWidget {
  const HomePageAdel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int gridCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(title: const Text("CineBooking"), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("movies").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No Movies Available"));

          
          final movies = snapshot.data!.docs.map((doc) {
            return MovieModelJevon.fromMapJevon(doc.data(), doc.id);
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, i) {
              return MovieCardAdel(
                movie: movies[i], 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailPageAdel(movie: movies[i]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}