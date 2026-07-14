import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platzi_api_architecture/data/models/auth_tokens.dart';
import 'package:platzi_api_architecture/data/repositories/auth_repository.dart';
import 'package:platzi_api_architecture/ui/core/network/api_result.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(LoginInitial());

  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await authRepository.login(email: email, password: password);

    switch (result) {
      case Success():
        emit(LoginSuccess(result.data));

      case Failure():
        emit(LoginError(errMessage: result.message));
    }
  }
}
