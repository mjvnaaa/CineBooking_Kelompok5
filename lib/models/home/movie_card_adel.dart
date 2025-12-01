import 'package:flutter/material.dart';
import '../../../models/home/movie_model_adel.dart';


class MovieCardAdel extends StatelessWidget {
  final MovieModelAdel movie;
  final VoidCallback onTap;

  const MovieCardAdel({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: movie.id, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movie.poster, 
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (ctx, error, stackTrace) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}