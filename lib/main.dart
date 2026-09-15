import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue,
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My First Flutter App!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Learning Flutter",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Aqil",
                  style: TextStyle(
                    fontSize: 16,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}