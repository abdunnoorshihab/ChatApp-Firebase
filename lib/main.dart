import 'package:chat_application/screens/auth/login.dart';

import '../../../const_config/color_config.dart';
import '../../../screens/auth/sign_up.dart';
import '../../../screens/chat/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Adding this line for fixing the app on portrait mode only.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Adding this line for disabling the system overlay color on top. so that our app scaffold color covers the hole screen
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primary),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const Dashboard();
            } else {
              return const LoginPage();
            }
          },
        ));
  }
}
