import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const ip = 'http://192.168.1.2:3000';
const String baseUrl = ip;
const String signInUrl = '$ip/auth/signin';
const String signUpUrl = '$ip/auth/signup';