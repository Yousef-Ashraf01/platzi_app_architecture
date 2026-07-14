part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthTokens tokens;

  LoginSuccess(this.tokens);
}

final class LoginError extends LoginState {
  final String errMessage;

  LoginError({required this.errMessage});
}
