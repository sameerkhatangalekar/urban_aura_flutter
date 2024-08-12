import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/extensions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';

part 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  final FirebaseAuth _firebaseAuth;

  const AuthRemoteDataSourceImpl(
      {required Dio dio,
      required FlutterSecureStorage storage,
      required FirebaseAuth firebaseAuth})
      : _dio = dio,
        _storage = storage,
        _firebaseAuth = firebaseAuth;

  @override
  Future<String> signin(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(signInUrl, data: {
        "email": email,
        "password": password,
      });
      final accessToken = response.data['accessToken'];
      final userCredentials =
          await _firebaseAuth.signInWithCustomToken(accessToken);
      final user = userCredentials.user;

      if (user == null) {
        await _firebaseAuth.signOut();
        throw const ServerException('Unable to process request at this time');
      }
      final token = await user.getIdToken();

      /// returns null if user is not signed in;
      if (token == null) {
        throw const ServerException('Unable to process request at this time');
      }
      return token;
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'custom-token-mismatch') {
        throw const ServerException('Token mismatch');
      } else if (e.code == 'invalid-custom-token') {
        throw const ServerException('Invalid token');
      } else {
        throw const ServerException('Unknown Firebase error');
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        throw const ServerException('Network error');
      } else {
        throw const ServerException('Unknown platform error');
      }
    } catch (e) {
      throw const ServerException('Unknown error occurred');
    }
  }

  // @override
  // Future<String> signInWithGoogle() async {
  //   try {
  //     final List<String> scopes = ['email', 'profile'];
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await GoogleSignIn(scopes: scopes).signIn();
  //
  //     if (googleSignInAccount == null) {
  //       throw const ServerException('Signin aborted');
  //     }
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     final UserCredential userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //
  //     if (user == null) {
  //       await _firebaseAuth.signOut();
  //       throw const ServerException('Unable to process request at this time');
  //     }
  //     final token = await user.getIdToken();
  //
  //     /// returns null if user is not signed in;
  //     if (token == null) {
  //       throw const ServerException('Unable to process request at this time');
  //     }
  //     return token;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'account-exists-with-different-credential') {
  //       throw const ServerException(
  //           'Account exists with different credentials');
  //     } else if (e.code == 'invalid-credential') {
  //       throw const ServerException('Invalid credentials');
  //     } else {
  //       throw const ServerException('Unknown Firebase error');
  //     }
  //   } on PlatformException catch (e) {
  //     if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
  //       throw const ServerException('Network error');
  //     } else {
  //       throw const ServerException('Unknown platform error');
  //     }
  //   } catch (e) {
  //     throw const ServerException('Unknown error occurred');
  //   }
  // }

  @override
  Future<String> signup(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final response = await _dio.post(signUpUrl, data: {
        "email": email,
        "password": password,
        "name": name,
      });

      final accessToken = response.data['accessToken'];
      final userCredentials =
          await _firebaseAuth.signInWithCustomToken(accessToken);
      final user = userCredentials.user;

      if (user == null) {
        await _firebaseAuth.signOut();
        throw const ServerException('Unable to process request at this time');
      }
      final token = await user.getIdToken();

      /// returns null if user is not signed in;
      if (token == null) {
        throw const ServerException('Unable to process request at this time');
      }
      return token;
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      final List<String> scopes = ['email', 'profile'];
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn(scopes:scopes ).signIn();

      if (googleSignInAccount == null) {
        throw const ServerException('Signin aborted');
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        await _firebaseAuth.signOut();
        throw const ServerException('Unable to process request at this time');
      }
      user.log();
      ///register the information to the server
      await _dio.post(signUpWithGoogleUrl, data: {
        "email": user.email,
        "uid": user.uid,
        "name": user.displayName,
      });
      final token = await user.getIdToken();

      if (token == null) {
        throw const ServerException('Unable to process request at this time');
      }
      return token;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw const ServerException(
            'Account exists with different credentials');
      } else if (e.code == 'invalid-credential') {
        throw const ServerException('Invalid credentials');
      } else {
        throw const ServerException('Unknown Firebase error');
      }
    } on PlatformException catch (e) {
      await _firebaseAuth.signOut();
      if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        throw const ServerException('Network error');
      } else {
        throw const ServerException('Unknown platform error');
      }
    } on DioException catch (e) {
      await _firebaseAuth.signOut();
      throw  ServerException(dioErrorProcessor(e));
    }  catch (e) {
      await _firebaseAuth.signOut();
      throw  const ServerException('Unknown error occurred');
    }
  }

  @override
  Future<void> signOut() async {
    await _storage.deleteAll();
    final user = _firebaseAuth.currentUser;
    try {
      if (user != null) {
        await _firebaseAuth.signOut();
      }
      if (_firebaseAuth.currentUser != null) {
        throw const ServerException('Error occurred while signing out');
      }
    } on FirebaseAuthException catch (_) {
      throw const ServerException('Unknown Firebase error');
    }
  }
}
