part of 'user_bloc.dart';


@immutable
abstract class UserState extends Equatable {
  const UserState();
}

final class UserInitialState extends UserState {
  const UserInitialState();

  @override
  List<Object?> get props => [];
}

final class UserAddressLoadingState extends UserState {
  const UserAddressLoadingState();

  @override
  List<Object?> get props => [];
}

final class UserAddressLoadedState extends UserState {
  final List<AddressEntity> addresses;

  const UserAddressLoadedState({required this.addresses});

  @override
  List<Object?> get props => [addresses];
}

final class UserAddressFailedState extends UserState {
  final String message;

  const UserAddressFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class UserActionLoadingState extends UserState {
  final String message;

  const UserActionLoadingState([this.message = 'Please wait...']);

  @override
  List<Object?> get props => [message];
}

final class UserActionSuccessState extends UserState {
  final String message;

  const UserActionSuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class UserActionFailedState extends UserState {
  final String message;

  const UserActionFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}
