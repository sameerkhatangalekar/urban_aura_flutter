// ignore_for_file: non_constant_identifier_names

import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel(
      {required super.id,
      required super.name,
      required super.city,
      required super.state,
      required super.country,
      required super.contact,
      required super.line_one,
      required super.postal_code,
      required super.userId});

  factory AddressModel.fromJson(Map<String, dynamic> map) {
      return AddressModel(
          id: map['id'],
          name: map['name'],
          city: map['city'],
          state: map['state'],
          country: map['country'],
          contact: map['contact'],
          line_one: map['line_one'],
          postal_code: map['postal_code'],
          userId: map['userId'],
      );
  }

  Map<String, dynamic> toJson() {
      return <String, dynamic> {
          'id': id,
          'name': name,
          'city': city,
          'state': state,
          'country': country,
          'contact': contact,
          'line_one': line_one,
          'postal_code': postal_code,
          'userId': userId
      };
  }

  AddressModel copyWith({
      String? id,
      String? name,
      String? city,
      String? state,
      String? country,
      String? contact,
      String? line_one,
      String? postal_code,
      String? userId,
  }) {
      return AddressModel(
          id: id ?? this.id,
          name: name ?? this.name,
          city: city ?? this.city,
          state: state ?? this.state,
          country: country ?? this.country,
          contact: contact ?? this.contact,
          line_one: line_one ?? this.line_one,
          postal_code: postal_code ?? this.postal_code,
          userId: userId ?? this.userId,
      );
  }


}
