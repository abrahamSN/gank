part of 'game_bloc.dart';

@immutable
abstract class GameState extends Equatable {}

class GameInitial extends GameState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GameFetchLoading extends GameState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GameFetchSuccess extends GameState {
  final CocktailModel cocktailModel;

  GameFetchSuccess({this.cocktailModel});

  @override
  // TODO: implement props
  List<Object> get props => [cocktailModel];
}

class GameFetchFailure extends GameState {
  final String error;

  GameFetchFailure({this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}