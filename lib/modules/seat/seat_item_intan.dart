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
    Color seatColorIntan;
    Color borderColorIntan;
    IconData? seatIconIntan;

    if (isSoldIntan) {
      seatColorIntan = const Color(0xFF2D1B1B);
      borderColorIntan = Colors.red.shade700;
      seatIconIntan = Icons.close;
    } else if (isSelectedIntan) {
      seatColorIntan = const Color(0xFF1A2634);
      borderColorIntan = Colors.amber.shade600;
      seatIconIntan = Icons.check;
    } else {
      seatColorIntan = const Color(0xFF1A1F29);
      borderColorIntan = Colors.grey.shade700;
      seatIconIntan = null;
    }

    return GestureDetector(
      onTap: isSoldIntan ? null : onTapIntan,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: seatColorIntan,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColorIntan,
            width: isSelectedIntan ? 2.5 : 1.5,
          ),
          boxShadow: isSelectedIntan
              ? [
                  BoxShadow(
                    color: Colors.amber.shade600.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : isSoldIntan
                  ? [
                      BoxShadow(
                        color: Colors.red.shade700.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ]
                  : [],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                seatNameIntan,
                style: TextStyle(
                  color: isSoldIntan ? Colors.red.shade400 : isSelectedIntan ? Colors.amber.shade600 : Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold,
                ),
              ),
              if (seatIconIntan != null) ...[
                const SizedBox(width: 2),
                Icon(
                  seatIconIntan, size: 12, color: isSoldIntan ? Colors.red.shade400 : Colors.amber.shade600,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}