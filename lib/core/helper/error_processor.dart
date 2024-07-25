import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/extensions.dart';

String dioErrorProcessor(DioException error) {
  if (error.response == null) {
    return 'An unexpected error occurred';
  }

  if (error.response?.data['message'] == null) {
    return 'An unexpected error occurred';
  }

  if (error.response!.data['message'].runtimeType == String) {
    return error.response!.data['message'].toString();
  }
  if (error.response!.data['message'].runtimeType == List<dynamic>) {
    var errorBuffer = StringBuffer();

    error.response!.data['message'].take(3).forEach((value) => errorBuffer.writeln(value.toString().capitalize()));
    return   errorBuffer.toString();
  }


  return 'An unexpected error occurred';
}
