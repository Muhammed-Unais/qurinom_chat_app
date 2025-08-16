import 'package:_qurinom_chat_app/features/auth/model/auth_response.dart';
import 'package:_qurinom_chat_app/features/auth/repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String email, String password, String role) async {
    emit(AuthLoading());
    try {
      final res = await repo.login(email, password, role);
      emit(AuthSuccess(res));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await repo.logout();
    emit(AuthInitial());
  }
}
