part of 'auth_bloc.dart';

class SignOutRequested extends AuthEvent {}

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// events
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}
