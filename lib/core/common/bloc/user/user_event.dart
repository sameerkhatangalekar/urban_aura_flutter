// ignore_for_file: non_constant_identifier_names

part of 'user_bloc.dart';

@immutable
sealed class UserEvent {
  const UserEvent();
}

final class GetAddressesEvent extends UserEvent {
  const GetAddressesEvent();
}

final class CreateAddressActionEvent extends UserEvent {
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const CreateAddressActionEvent(
      {required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class UpdateAddressActionEvent extends UserEvent {
  final String addressId;

  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const UpdateAddressActionEvent(
      {required this.addressId,
      required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class DeleteAddressActionEvent extends UserEvent {
  final String addressId;

  const DeleteAddressActionEvent({required this.addressId});
}
