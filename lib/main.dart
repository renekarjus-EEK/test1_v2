import 'package:flutter/material.dart';
import 'screens/random_number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => RandomNumberScreen(),
      },
      initialRoute: '/',
    );
  }
}
