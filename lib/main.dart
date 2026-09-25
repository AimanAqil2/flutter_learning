import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Student model
class Student {
  final String name;
  final int age;
  final String course;

  const Student({required this.name, required this.age, required this.course});
}

class StudentTile extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentTile({super.key, required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(student.name),
        subtitle: Text(student.course),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
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

  final List<Student> students = const [
    Student(name: "Aqil", age: 20, course: "Computer Science"),
    Student(name: "Abu", age: 21, course: "Information Technology"),
    Student(name: "Ahmad", age: 20, course: "Computer Science"),
    Student(name: "Ali", age: 22, course: "Software Engineering"),
    Student(name: "Aiman", age: 21, course: "Information Technology"),
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
                  return StudentTile(
                    student: students[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailPage(student: students[index]),
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
  final Student student;

  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Detail")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name: ${student.name}", style: const TextStyle(fontSize: 24)),

            Text("Age: ${student.age}", style: const TextStyle(fontSize: 20)),

            Text(
              "Course: ${student.course}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
