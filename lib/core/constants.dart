import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<ScaffoldState> searchPageKey = GlobalKey<ScaffoldState>();
const String stripePublishableKey = 'pk_test_51ObfGPSFnT4ApGmzxg9pukvNH0PmeAaMxauptm6HCGE5UP3x7M8UAEkIqt2dmeWiTu3beVl8qCjJsKvoz2NpfBQU00slPP1uQh';

const ip = 'http://192.168.1.2:3000';
const String baseUrl = ip;
const String signInUrl = '$ip/auth/signin';
const String signUpUrl = '$ip/auth/signup';
const String userUrl = '$ip/user';
const String productUrl = '$ip/products';
const String cartUrl = '$ip/cart';
const String ordersUrl = '$ip/order';
const String checkoutUrl = '$ip/checkout';
const String incrementCartItemCountUrl = '$cartUrl/increment';
const String decrementCartItemCountUrl = '$cartUrl/decrement';
const String algoliaAppId = 'DELC2LAXC9';
const String algoliaSearchKey = '6020027d9edaca8b4a7cc457944e661d';