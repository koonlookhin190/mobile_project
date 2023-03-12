import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/page/home.dart';
import 'package:mobile_project/page/login.dart';

import 'module/Utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _sub;
  final _navigatorKey = new GlobalKey<NavigatorState>();

    @override
  void initState() {
    super.initState();

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
    _sub = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? 'home' : 'login',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelloWorld',
      navigatorKey: _navigatorKey,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(
              settings: settings,
              builder: (con) => Home()
            );
          case 'login':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => MyLogin(),
            );
        }
      }
      );
  
  }
}


