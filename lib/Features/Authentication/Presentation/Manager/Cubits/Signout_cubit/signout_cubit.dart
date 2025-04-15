import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Domain/repo/auth_repo.dart';

part 'signout_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit({ required this.authRepo}) : super(SignOutInitial());

  final AuthRepo authRepo;
  Future<void> SignOut() async {
    emit(SignOutLoading());
    final result = await authRepo.SignOut();
    result.fold((Failure) => emit(SignOutFailure( Failure.message)),
            (message) => emit(SignOutSuccess()));
  }
}
