import 'package:firebase_auth/firebase_auth.dart';
import 'package:managemint/Features/Authentication/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.password});
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(email: user.email ?? '', password: user.uid);
  }
}
