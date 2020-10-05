part of 'navbar_bloc.dart';

@immutable
abstract class NavbarState extends Equatable {}

class NavbarInitial extends NavbarState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NavbarChangedPage extends NavbarState {
  final int index;
  final NavbarItem navbarItem;

  NavbarChangedPage({this.index, this.navbarItem});

  @override
  // TODO: implement props
  List<Object> get props => [index, navbarItem];
}
