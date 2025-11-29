import 'package:flutter/material.dart';

class SeatItemIntan extends StatelessWidget {
  final bool isSelectedIntan;
  final bool isSoldIntan;
  final String seatNameIntan;
  final VoidCallback onTapIntan;

  const SeatItemIntan({
    super.key,
    required this.isSelectedIntan,
    required this.isSoldIntan,
    required this.seatNameIntan,
    required this.onTapIntan,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColorIntan;

    if (isSoldIntan) {
      seatColorIntan = Colors.red;      
    } else if (isSelectedIntan) {
      seatColorIntan = Colors.blue;     
    } else {
      seatColorIntan = Colors.grey;     
    }

    return GestureDetector(
      onTap: isSoldIntan ? null : onTapIntan,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: seatColorIntan,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          seatNameIntan,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
