import 'package:flutter/material.dart';
import 'package:student_info_app/functions/function.dart';
import 'package:student_info_app/screens/studentadd.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentData(
        studentData: {},
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
