part of 'signout_cubit.dart';

@immutable
sealed class SignOutState{}

final class SignOutInitial extends SignOutState{}
final class SignOutLoading extends SignOutState{}
final class SignOutSuccess extends SignOutState{}
final class SignOutFailure extends SignOutState{
  final String errorMessage;
  SignOutFailure(this.errorMessage);
}
