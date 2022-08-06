import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata/models/model/user_model.dart';
import 'package:khata/routes/route_generator.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicatonDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user_box');

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.kIntroScreen,
      onGenerateRoute: AppRouteGenerator.generateScreen,
    ),
  );
}
