import 'package:flutter/material.dart';
import 'ticket_model_fariz.dart';

class TicketProviderFariz extends ChangeNotifier {
  final List<TicketFariz> _tickets = [];

  List<TicketFariz> get tickets => List.unmodifiable(_tickets);

  void setTickets(List<TicketFariz> tickets) {
    _tickets.clear();
    _tickets.addAll(tickets);
    notifyListeners();
  }
}