import 'package:flutter/material.dart';

class SeatItemIntan extends StatelessWidget {
  final String seatNameIntan;
  final bool isSoldIntan;
  final bool isSelectedIntan;
  final VoidCallback onTapIntan;

  const SeatItemIntan({
    super.key,
    required this.seatNameIntan,
    required this.isSoldIntan,
    required this.isSelectedIntan,
    required this.onTapIntan,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isSoldIntan) {
      backgroundColor = const Color(0xFF2D1B1B);
      borderColor = Colors.red.shade700;
      textColor = Colors.red.shade700;
    } else if (isSelectedIntan) {
      backgroundColor = const Color(0xFF1A2634);
      borderColor = Colors.amber.shade600;
      textColor = Colors.amber.shade600;
    } else {
      backgroundColor = const Color(0xFF1A1F29);
      borderColor = Colors.grey.shade700;
      textColor = Colors.grey.shade500;
    }

    return GestureDetector(
      onTap: isSoldIntan ? null : onTapIntan,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
          boxShadow: isSelectedIntan
              ? [
                  BoxShadow(
                    color: Colors.amber.shade600.withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Icon(
            Icons.event_seat,
            size: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
