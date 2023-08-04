part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeMapUpdated extends HomeState {}

class HomeMapLoading extends HomeState {}

class HomeMapError extends HomeState {
  final String message;
  HomeMapError({this.message = "Something went wrong"});

  @override
  List<Object> get props => [message];
}
