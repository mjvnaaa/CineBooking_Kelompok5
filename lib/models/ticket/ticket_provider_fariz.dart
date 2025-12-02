import 'package:flutter/material.dart';
import 'ticket_model_fariz.dart';

class TicketProviderFariz extends ChangeNotifier {
  final List<TicketFariz> _tickets = [];

  List<TicketFariz> get tickets => List.unmodifiable(_tickets);

  void addTicketFariz(TicketFariz ticket) {
    _tickets.add(ticket);
    notifyListeners();
  }
}
