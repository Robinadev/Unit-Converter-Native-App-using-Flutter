import 'package:flutter/material.dart';
import 'category_route.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          titleTextStyle: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      home: const CategoryRoute(),
    );
  }
}
