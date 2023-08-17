part of 'verify_id_cubit.dart';

abstract class VerifyIdState extends Equatable {
  const VerifyIdState();

  @override
  List<Object> get props => [];
}

class VerifyIdInitial extends VerifyIdState {}

class VerifyIdLoading extends VerifyIdState {}

class VerifyIdSuccess extends VerifyIdState {}

class VerifyIdFailure extends VerifyIdState {
  final String message;
  const VerifyIdFailure({required this.message});
  @override
  List<Object> get props => [message];
}
