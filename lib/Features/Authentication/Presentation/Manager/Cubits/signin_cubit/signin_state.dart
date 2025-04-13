import 'package:managemint/Features/Authentication/entity/user_entity.dart';

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninSuccess extends SigninState {
  final UserEntity userEntity;
  SigninSuccess({required this.userEntity});
}

class SigninLoading extends SigninState {}

class SigninFailure extends SigninState {
  final String errorMessage;
  SigninFailure({required this.errorMessage});
}
