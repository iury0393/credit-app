import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credit Card',
      theme: ThemeData(brightness: Brightness.dark),
      home: ChangeNotifierProvider(
        child: HomePage(),
        create: (BuildContext context) => PageControllerApp(),
      ),
    );
  }
}
