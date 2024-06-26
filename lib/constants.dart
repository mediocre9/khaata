import 'dart:ui';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/models/model/product.dart';
import 'package:khata/models/model/customer.dart';

const Color kAppBarForeColor = Color.fromRGBO(100, 100, 100, 1);
const Color kAppBarBackColor = Color.fromRGBO(254, 254, 254, 1);
const Color kScaffoldColor = Color.fromRGBO(253, 253, 253, 1.0);
const Color kTextColor = Color.fromRGBO(33, 33, 33, 1.0);
const Color kBlueGradient = Color.fromARGB(255, 18, 25, 78);
const Color kTealGradient = Color.fromARGB(255, 53, 100, 88);
const Color kCardTextColor = Color.fromRGBO(255, 255, 255, 1.0);
const Color kDrawerItemColor = Color.fromRGBO(255, 255, 255, 1.0);
const Color kDrawerSplashColor = Color.fromARGB(61, 215, 216, 255);
const Color kSnackBarSuccessColor = Color.fromARGB(255, 69, 189, 85);
const Color kSnackBarErrorColor = Color.fromARGB(255, 223, 71, 71);
const double kDrawerItemFontSize = 14.0;
const double kDrawerSubItemFontSize = 10.0;

Box<Customer>? customerBox;
Box<Product>? productBox;
Box<Order>? orderBox;

const String kAppName = "KHAATA";
const String kCompany = "SMART ALPHA SOFTWARE HOUSE";
