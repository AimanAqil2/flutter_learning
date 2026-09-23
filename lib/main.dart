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
  String displayedName = "";
  String errorMessage = "";
  String status = "";

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
                  Text("Status: $status"),
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
                            content: Text("Name submitted successfully!"),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (displayedName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please submit your name first!"),
                          ),
                        );
                      } else {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SecondPage(name: displayedName),
                          ),
                        );

                        setState(() {
                          status = result ?? "";
                        });
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

  final List<Map<String, dynamic>> students = const [
    {"name": "Aqil", "age": 20, "course": "Computer Science"},
    {"name": "Abu", "age": 21, "course": "Information Technology"},
    {"name": "Ahmad", "age": 20, "course": "Computer Science"},
    {"name": "Ali", "age": 22, "course": "Software Engineering"},
    {"name": "Aiman", "age": 21, "course": "Information Technology"},
  ];

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

            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(students[index]["name"]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailPage(
                            studentName: students[index]["name"],
                            studentAge: students[index]["age"],
                            studentCourse: students[index]["course"],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Completed");
              },
              child: const Text("Complete"),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDetailPage extends StatelessWidget {
  final String studentName;
  final int studentAge;
  final String studentCourse;

  const StudentDetailPage({
    super.key,
    required this.studentName,
    required this.studentAge,
    required this.studentCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Detail")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name: $studentName", style: const TextStyle(fontSize: 24)),
            Text("Age: $studentAge", style: const TextStyle(fontSize: 20)),
            Text(
              "Course: $studentCourse",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
