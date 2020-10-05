part of 'navbar_bloc.dart';

@immutable
abstract class NavbarEvent extends Equatable {}

class PickItem extends NavbarEvent{
  final int index;

  PickItem({this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];
}
