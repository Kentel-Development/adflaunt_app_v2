part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class MainLoading extends MainState {}

final class MainLoggedIn extends MainState {}

final class MainLoggedOut extends MainState {}

final class MainNoInternet extends MainState {}
