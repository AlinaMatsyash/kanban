import 'dart:convert';

import 'package:http/http.dart';
import 'package:kanban/bloc/cards/cards_bloc.dart';

class CardsRepository {
  final String? token;

  CardsRepository({this.token});

  late final Client http = Client();

  Future<List<Card>> fetchCards() async {
    var cards = <Card>[];
    print(token);
    final response = await http.get(
        Uri.parse(
          'https://trello.backend.tests.nekidaem.ru/api/v1/cards/',
        ),
        headers: {
          'Authorization': 'JWT $token',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((card) => Card(
                text: card['text'],
                id: card['id'],
                row: card['row'],
              ))
          .toList();
    } else {
      print(response.statusCode);
      print(response.body);
    }
    return cards;
  }
}
