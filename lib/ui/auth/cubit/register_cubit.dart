import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platzi_api_architecture/data/models/register_body.dart';
import 'package:platzi_api_architecture/data/repositories/auth_repository.dart';
import 'package:platzi_api_architecture/ui/core/network/api_result.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepository}) : super(RegisterInitial());

  final AuthRepository authRepository;

  Future<void> register({
    required RegisterBody registerBody,
    required Uint8List imageBytes,
    required String imageName,
  }) async {
    emit(RegisterLoading());

    final uploadResult = await authRepository.uploadAvatar(
      bytes: imageBytes,
      fileName: imageName,
    );
    if (uploadResult case Failure()) {
      emit(RegisterError(message: uploadResult.message));
      return;
    }

    final imageUrl = (uploadResult as Success<String>).data;
    final result = await authRepository.register(
      registerBody: RegisterBody(
        name: registerBody.name,
        email: registerBody.email,
        password: registerBody.password,
        avatar: imageUrl,
      ),
    );

    switch (result) {
      case Success():
        emit(RegisterSuccess());
      case Failure():
        emit(RegisterError(message: result.message));
    }
  }
}
