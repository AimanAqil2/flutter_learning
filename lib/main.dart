import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  String displayedName = "";
  String errorMessage = "";

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "My First Flutter App!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Learning Flutter",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(controller: nameController),
                  Text("Hello $displayedName"),
                  Text(errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) {
                        setState(() {
                          displayedName = "";
                          errorMessage = "Please enter your name";
                        });
                      } else {
                        setState(() {
                          displayedName = nameController.text.trim();
                          errorMessage = "";
                        });

                        nameController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Name submitted succesfully!"),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                  Text(
                    "$counter",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            counter++;
                          });
                        },
                        child: const Text("Add 1"),
                      ),

                      const SizedBox(width: 20),

                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            counter--;
                          });
                        },
                        child: const Text("Minus 1"),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (displayedName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please submit your name first!"),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SecondPage(name: displayedName),
                          ),
                        );
                      }
                    },
                    child: const Text("Next Page"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String name;

  const SecondPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Welcome $name!", style: const TextStyle(fontSize: 24)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Complete"),
            ),
          ],
        ),
      ),
    );
  }
}
