import 'package:flutter/material.dart';
import 'seat_item_intan.dart';

class SeatPageIntan extends StatefulWidget {
  final String movieTitleIntan;
  final int basePriceIntan;

  const SeatPageIntan({
    super.key,
    required this.movieTitleIntan,
    required this.basePriceIntan,
  });

  @override
  State<SeatPageIntan> createState() => _SeatPageIntanState();
}

class _SeatPageIntanState extends State<SeatPageIntan> {
  List<String> selectedSeatsIntan = [];

  // contoh kursi terjual (seharusnya dari firebase)
  final List<String> soldSeatsIntan = ["A3", "C5"];

  @override
  Widget build(BuildContext context) {
    List<String> rowLettersIntan = ["A", "B", "C", "D", "E", "F"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Kursi - ${widget.movieTitleIntan}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: 6 * 8, // 6 baris × 8 kolom
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            int rowIndexIntan = index ~/ 8; // 0–5
            int colIndexIntan = (index % 8) + 1; // 1–8

            String seatNameIntan =
                "${rowLettersIntan[rowIndexIntan]}$colIndexIntan";

            bool soldIntan = soldSeatsIntan.contains(seatNameIntan);
            bool selectedIntan =
                selectedSeatsIntan.contains(seatNameIntan);

            return SeatItemIntan(
              seatNameIntan: seatNameIntan,
              isSoldIntan: soldIntan,
              isSelectedIntan: selectedIntan,
              onTapIntan: () {
                setState(() {
                  if (selectedIntan) {
                    selectedSeatsIntan.remove(seatNameIntan);
                  } else {
                    selectedSeatsIntan.add(seatNameIntan);
                  }
                });
              },
            );
          },
        ),
      ),

      // tombol floating
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Book Now"),
        onPressed: () {
          print("Selected seats Intan: $selectedSeatsIntan");
        },
      ),
    );
  }
}
