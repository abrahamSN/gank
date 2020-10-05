import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final CocktailRepository _cocktailRepository = CocktailRepository();
  GameBloc() : super(GameInitial());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchingGame) {
      yield GameFetchLoading();

      try {
        final CocktailModel _cocktailModel = await _cocktailRepository.getAll();
        yield GameFetchSuccess(cocktailModel: _cocktailModel);
      } catch (e) {
        yield GameFetchFailure(error: e.toString());
      }
    }
  }
}
