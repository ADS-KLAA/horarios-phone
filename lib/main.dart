import 'package:flutter/material.dart';
import 'package:horarios_phone/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 29, 78, 216)),
      title: 'Horários',
      routerConfig: router,
    );
  }
}
