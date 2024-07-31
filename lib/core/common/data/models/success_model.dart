import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';

final class SuccessModel extends SuccessEntity {
  SuccessModel({required super.message});

  factory SuccessModel.fromJson(Map<String, dynamic> map) {
    return SuccessModel(message: map['message']);
  }

  SuccessModel copyWith({String? message}) {
    return SuccessModel(message: message ?? this.message);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'message': message};
  }
}
