import 'package:dartz/dartz.dart';
import 'package:managemint/Core/Services/firebase_auth_services.dart';
import 'package:managemint/Core/errors/exceptions.dart';
import 'package:managemint/Core/errors/failures.dart';
import 'package:managemint/Features/Authentication/Data/Model/user_model.dart';
import 'package:managemint/Features/Authentication/Domain/repo/auth_repo.dart';
import 'package:managemint/Features/Authentication/entity/user_entity.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  AuthRepoImpl({required this.firebaseAuthServices});
  @override
  Future<Either<Failure, UserEntity>> CreateUserWithEmailandPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthServices.createUserwithEmialandPassword(
          email: email, password: password);
      return right(UserModel.fromFirebaseUser(user));
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> SigninWithEmailandPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailandPassword(
          email: email, password: password);
      return right(UserModel.fromFirebaseUser(user));
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
