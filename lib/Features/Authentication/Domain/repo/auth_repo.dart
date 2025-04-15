import 'package:dartz/dartz.dart';
import 'package:managemint/Core/errors/failures.dart';
import 'package:managemint/Features/Authentication/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> CreateUserWithEmailandPassword(
      String email, String password,  String userName,String userRole);
  Future<Either<Failure, UserEntity>> SigninWithEmailandPassword(
      String email, String password);
  Future<Either<Failure, String>> SignOut();
}
