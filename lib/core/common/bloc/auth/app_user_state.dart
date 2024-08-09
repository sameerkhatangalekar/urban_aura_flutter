part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {
  const AppUserInitial();
  @override
  List<Object> get props => [];
}

final class AppUserLoggedInState extends AppUserState {
  const AppUserLoggedInState();
  @override
  List<Object?> get props => [];
}


final class AppUserLoggedOutState extends AppUserState {
  final String message;
  const AppUserLoggedOutState({ this.message = 'Logged out successfully'});

  @override
  List<Object?> get props => [message];
}
