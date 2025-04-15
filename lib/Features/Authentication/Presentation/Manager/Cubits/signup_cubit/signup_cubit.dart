import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managemint/Features/Authentication/Domain/repo/auth_repo.dart';
import 'package:managemint/Features/Authentication/Presentation/Manager/Cubits/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;
  Future<void> createUserwithEmailandPassword(
      {required String email, required String password, required String userName ,required String userRole}) async {
    emit(SignupLoading());
    final result =
        await authRepo.CreateUserWithEmailandPassword(email, password,userName ,userRole);
    result.fold((Failure) => emit(SignupFailure(errorMessage: Failure.message)),
        (UserEntity) => emit(SignupSuccess(userEntity: UserEntity)));
  }
}
