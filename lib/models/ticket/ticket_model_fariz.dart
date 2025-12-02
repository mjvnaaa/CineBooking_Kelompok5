class TicketFariz {
  final String movie;
  final List<String> seats;
  final DateTime date;
  final String bookingId;
  final int totalPrice;

  TicketFariz({
    required this.movie,
    required this.seats,
    required this.date,
    required this.bookingId,
    required this.totalPrice,
  });
}