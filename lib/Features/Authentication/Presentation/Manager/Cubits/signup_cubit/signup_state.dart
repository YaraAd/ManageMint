import 'package:managemint/Features/Authentication/entity/user_entity.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupSuccess extends SignupState {
  final UserEntity userEntity;
  SignupSuccess({required this.userEntity});
}

class SignupLoading extends SignupState {}

class SignupFailure extends SignupState {
  final String errorMessage;
  SignupFailure({required this.errorMessage});
}
