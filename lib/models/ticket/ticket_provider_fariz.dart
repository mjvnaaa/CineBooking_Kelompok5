import 'package:flutter/material.dart';
import 'ticket_model_jevon.dart';

class TicketProviderFariz extends ChangeNotifier {
  final List<TicketJevon> _tickets = [];

  List<TicketJevon> get tickets => List.unmodifiable(_tickets);

  void setTickets(List<TicketJevon> tickets) {
    _tickets.clear();
    _tickets.addAll(tickets);
    notifyListeners();
  }
}