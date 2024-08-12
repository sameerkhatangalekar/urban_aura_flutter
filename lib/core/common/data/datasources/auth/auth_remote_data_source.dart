part of 'auth_remote_data_source_impl.dart';
abstract interface class AuthRemoteDataSource {
  Future<String> signInWithGoogle();
  Future<String> signin({required String email, required String password});
  Future<String> signup({required String email, required String name ,required String password});
  Future<void> signOut();

  Stream<bool> get userState;
}
