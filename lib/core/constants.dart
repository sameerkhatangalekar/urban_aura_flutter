import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const ip = 'http://192.168.1.5:3000';
const String baseUrl = ip;
const String signInUrl = '$ip/auth/signin';
const String signUpUrl = '$ip/auth/signup';
const String productUrl = '$ip/products';
const String cartUrl = '$ip/cart';
const String incrementCartItemCountUrl = '$cartUrl/increment';
const String decrementCartItemCountUrl = '$cartUrl/decrement';
