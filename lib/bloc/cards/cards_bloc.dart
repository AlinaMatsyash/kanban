import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kanban/repository/auth_repository.dart';
import 'package:kanban/repository/cards_repository.dart';
import 'package:meta/meta.dart';

part 'cards_event.dart';

part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({this.auth})
      : repository = CardsRepository(token: auth?.token),
        super(CardsInitial()) {
    fetch();
  }

  late final CardsRepository repository;
  final AuthRepository? auth;

  @override
  Stream<CardsState> mapEventToState(
    CardsEvent event,
  ) async* {
    if (event is LoadCardsEvent) {
      yield CardsLoading();
      final cards = await repository.fetchCards();
      final cardGroups =
          cards.fold<Map<String, List<Card>>>({}, (previousValue, element) {
        final cards = previousValue.putIfAbsent(element.row, () => <Card>[]);

        cards.add(element);

        previousValue[element.row] = cards;
        return previousValue;
        //return;
      });

      yield CardsReady(cardGroups);
    }
  }

  fetch() => add(LoadCardsEvent());
}
