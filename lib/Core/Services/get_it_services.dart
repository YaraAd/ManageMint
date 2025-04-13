import 'package:get_it/get_it.dart';
import 'package:managemint/Core/Services/firebase_auth_services.dart';
import 'package:managemint/Features/Authentication/Data/repo/auth_repo_impl.dart';
import 'package:managemint/Features/Authentication/Domain/repo/auth_repo.dart';

// For register with singleton "DESIGN PATTERN"
final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
    firebaseAuthServices: getIt<FirebaseAuthServices>(),
  ));
}
