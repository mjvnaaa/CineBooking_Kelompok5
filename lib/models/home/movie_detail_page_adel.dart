import 'package:flutter/material.dart';
import '../movie_model_jevon.dart';
import '../../modules/seat/seat_page_intan.dart'; 

class MovieDetailPageAdel extends StatelessWidget {
  final MovieModelJevon movie; 

  const MovieDetailPageAdel({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeatPageIntan(
                movieTitleIntan: movie.title, 
                basePriceIntan: movie.basePrice, 
              ),
            ),
          );
        },
        label: const Text("Book Ticket"),
      ),
      body: SingleChildScrollView(
         child: Column(
           children: [
              Image.network(movie.poster), 
              Text(movie.title),
              Text("Rp ${movie.basePrice}"),
           ],
         ),
      ),
    );
  }
}
