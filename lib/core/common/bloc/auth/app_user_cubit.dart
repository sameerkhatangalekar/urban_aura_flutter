import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final FlutterSecureStorage _storage;

  AppUserCubit({required FlutterSecureStorage storage})
      : _storage = storage,
        super(const AppUserInitial());

  void login() => emit(const AppUserLoggedInState());

  void logout({String message = 'Logged out successfully'}) async {
    await _storage.deleteAll();
    emit(AppUserLoggedOutState(message: message));
  }

  void getCurrentUser() async {
    await _storage.containsKey(key: 'jwtToken')
        ? emit(const AppUserLoggedInState())
        : emit(const AppUserInitial());
  }
}
