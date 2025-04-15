import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managemint/Features/Authentication/Domain/repo/auth_repo.dart';
import 'package:managemint/Features/Authentication/Presentation/Manager/Cubits/signin_cubit/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;
  Future<void> createUserwithEmailandPassword(
      {required String email, required String password}) async {
    emit(SigninLoading());
    final result = await authRepo.SigninWithEmailandPassword(email, password);
    result.fold((Failure) => emit(SigninFailure(errorMessage: Failure.message)),
        (UserEntity) => emit(SigninSuccess(userEntity: UserEntity)));
  }

}
