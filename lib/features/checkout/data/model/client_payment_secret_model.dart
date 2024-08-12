import 'package:urban_aura_flutter/features/checkout/domain/entity/client_payment_secret_entity.dart';

final class ClientPaymentSecretModel extends ClientPaymentSecretEntity {
  const ClientPaymentSecretModel({required super.clientSecret,required super.publishableKey});

  factory ClientPaymentSecretModel.fromJson(Map<String, dynamic> map) =>
      ClientPaymentSecretModel(clientSecret: map['clientSecret'],publishableKey: map['publishableKey']);

  Map<String, dynamic> toJson() => {'clientSecret': clientSecret,'publishableKey' : publishableKey};




}
