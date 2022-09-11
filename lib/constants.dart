import 'dart:ui';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/models/model/order_model.dart';
import 'package:khata/models/model/product_model.dart';
import 'package:khata/models/model/user_model.dart';

const Color kAppBarForeColor = Color.fromRGBO(100, 100, 100, 1);
const Color kAppBarBackColor = Color.fromRGBO(254, 254, 254, 1);
const Color kScaffoldColor = Color.fromRGBO(253, 253, 253, 1.0);
const Color kTextColor = Color.fromRGBO(33, 33, 33, 1.0);
const Color kBlueGradient = Color.fromARGB(255, 18, 25, 78);
const Color kTealGradient = Color.fromARGB(255, 53, 100, 88);
const Color kCardTextColor = Color.fromRGBO(255, 255, 255, 1.0);
const Color kDrawerItemColor = Color.fromRGBO(255, 255, 255, 1.0);
const Color kDrawerSplashColor = Color.fromARGB(61, 215, 216, 255);
const double kDrawerItemFontSize = 16.5;
const double kDrawerSubItemFontSize = 12.0;
const Color kSnackBarSuccessColor = Color.fromARGB(255, 69, 189, 85);
const Color kSnackBarErrorColor = Color.fromARGB(255, 223, 71, 71);

Box<UserModel>? userBox;
Box<ProductModel>? productBox;
Box<OrderModel>? orderBox;

List<ProductModel?> productList = [];
List<OrderModel?> orderList = [];

const String kAppName = "Khaata";
const String kCompany = "Smart Alpha Software House";
