part of 'cards_bloc.dart';

@immutable
abstract class CardsState {}

class CardsInitial extends CardsState {}

class CardsLoading extends CardsState {}

class CardsReady extends CardsState {
  CardsReady(this.cards);

  Map<String,List<Card>> cards;
}

class Card {
  final int id;
  final String text;
  final String row;

  Card({required this.text, required this.id, required this.row,});
}
