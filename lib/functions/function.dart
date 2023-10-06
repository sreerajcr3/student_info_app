import 'package:sqflite/sqflite.dart';
import '../screens/model.dart';

late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "student.db",
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY, rollno TEXT, name TEXT, department TEXT, phoneno TEXT, imageurl);");
    },
  );
}

Future<void> addstudent(StudentModel value) async {
  await _db.rawInsert(
      "INSERT INTO student (id, rollno, name, department, phoneno, imageurl) VALUES (?, ?, ?, ?, ?, ?)",
      [
        value.id,
        value.rollno,
        value.name,
        value.department,
        value.phoneno,
        value.imageurl
      ]);
}

Future<List<Map<String, dynamic>>> getAllStudents() async {
  final _values = await _db.rawQuery('SELECT * FROM student');
  return _values;
}

Future<void> deleteStudent(int id) async{
  await _db.rawDelete('DELETE FROM student WHERE id = ?',[id]);
}

Future <void> updatedStudent(StudentModel updatedStudent) async{
  await _db.update('student', {
    'name':updatedStudent.name,
    'rollno':updatedStudent.rollno,
    'phoneno':updatedStudent.phoneno,
    'imageurl':updatedStudent.imageurl,
  },
  where: 'id = ?',
  whereArgs: [updatedStudent.id],
  );
}
