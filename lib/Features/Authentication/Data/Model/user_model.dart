import 'package:firebase_auth/firebase_auth.dart';
import 'package:managemint/Features/Authentication/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.password, required super.userName, required super.role, required super.uid });
  factory UserModel.fromFirebaseUser(User user, String role, String username, String uid) {
    return UserModel(email: user.email ?? '', password: user.uid, userName: username, role: role, uid: uid );
  }
}
