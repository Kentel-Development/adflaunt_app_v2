part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterVerified extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterCodeSent extends RegisterState {
  const RegisterCodeSent({required this.verificationId});
  final String verificationId;

  @override
  List<Object> get props => [verificationId];
}

class RegisterFailure extends RegisterState {
  const RegisterFailure({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
