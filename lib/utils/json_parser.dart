// import 'dart:convert' show jsonDecode;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:khata/models/user_model.dart';

// // designed for json parsing ....
// class JsonParser {
//   static Future<List<UserModel>> get readData async {
//     String jsonString = await rootBundle.loadString("assets/user.json");
//     var jsonObject = jsonDecode(jsonString);
//     List<Map<String, dynamic>> jsonObjList = List.from(jsonObject);
//     return jsonObjList.map((e) => UserModel.fromJson(e)).toList();
//   }
// }
