import 'package:cinebooking_kelompok5/controllers/seat_controller.dart';
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
  final List<String> soldSeatsIntan = ["A3", "C5"];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeatControllerSalam>().initData(
        basePriceInput: widget.basePriceIntan,
        movieTitleInput: widget.movieTitleIntan,
      );
    });
  }

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
          itemCount: 6 * 8, 
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            int rowIndexIntan = index ~/ 8; 
            int colIndexIntan = (index % 8) + 1; 

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

      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Book Now"),
        onPressed: () {
          print("Selected seats Intan: $selectedSeatsIntan");
        },
      ),
    );
  }
}
