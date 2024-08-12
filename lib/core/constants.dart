import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<ScaffoldState> searchPageKey = GlobalKey<ScaffoldState>();
const ip = 'https://urban-aura-backend.onrender.com';
const String baseUrl = ip;
const String signInUrl = '$ip/auth/signin';
const String signUpUrl = '$ip/auth/signup';
const String signUpWithGoogleUrl = '$ip/auth/google/signin';
const String userUrl = '$ip/user';
const String productUrl = '$ip/products';
const String cartUrl = '$ip/cart';
const String ordersUrl = '$ip/order';
const String checkoutUrl = '$ip/checkout';
const String incrementCartItemCountUrl = '$cartUrl/increment';
const String decrementCartItemCountUrl = '$cartUrl/decrement';
const String algoliaAppId = 'DELC2LAXC9';
const String algoliaSearchKey = '6020027d9edaca8b4a7cc457944e661d';