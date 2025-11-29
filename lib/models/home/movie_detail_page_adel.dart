import 'package:flutter/material.dart';
import  '../../../models/home/movie_model_adel.dart';


class MovieDetailPageAdel extends StatelessWidget {
  final MovieModelAdel movie;

  const MovieDetailPageAdel({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/seat-page",
            arguments: movie,
          );
        },
        label: const Text("Book Ticket"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Hero(
              tag: movie.movieId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 360,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  movie.rating.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              "Duration: ${movie.duration} minutes",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            Text(
              "Base Price: Rp ${movie.basePrice}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Enjoy your best cinema experience with CineBooking!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
