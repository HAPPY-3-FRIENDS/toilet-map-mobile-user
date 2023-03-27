import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/routes.dart';
import 'package:toiletmap/app/utils/router.dart' as router;
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Nhà vệ sinh công cộng",
      debugShowCheckedModeBanner: false,
      home: Center(child: Text('Dự án Nhà vệ sinh công cộng')),
      initialRoute: Routes.loginOTPConfirmationScreen,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
