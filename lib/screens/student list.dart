import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info_app/functions/function.dart';
import 'package:student_info_app/screens/studentadd.dart';
import 'package:student_info_app/screens/studentdetails.dart';

class studentList extends StatefulWidget {
  const studentList({super.key});
  

  @override
  State<studentList> createState() => _studentListState();
}

class _studentListState extends State<studentList> {
  late List<Map<String, dynamic>> _studentData = [];
 TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchStudentsData();
  }

  Future<void> _fetchStudentsData() async {
    List<Map<String, dynamic>> students = await getAllStudents();
if (_searchController.text.isNotEmpty) {
      students = students
          .where(
            (student) => student['name'].toString().toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _studentData = students;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Student List",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
               controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _fetchStudentsData();
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                hintText: ' Search',
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 2, color: Colors.white10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 2, color: Colors.white10),
                ),
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 12),
        child: _studentData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No students available.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentData(studentData: {},)));
                      },
                      child: const Text(
                        'Add New Student?',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    )
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  final student = _studentData[index];
                  final id = student['id'];
                  final imageUrl = student['imageurl'];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => studentDetails(
                                studentData: _studentData[index])),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 77, 53, 115)),
                      child: SizedBox(
                        height: 100,
                        child: GridTileBar(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: GestureDetector(
                              onTap: () {
                                if (imageUrl != null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.file(File(imageUrl)),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                backgroundImage: imageUrl != null
                                    ? FileImage(File(imageUrl))
                                    : null,
                                child: imageUrl == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              student['name'],
                              style: const TextStyle(fontSize: 19),
                            ),
                          ),
                          subtitle: Text(
                            student['department'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [          
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor:
                                          const Color.fromARGB(255, 52, 52, 62),
                                      title: const Text(
                                        "Delete Student",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      content: const Text(
                                        "Are you sure you want to delete?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await deleteStudent(
                                                id); // Delete the student
                                            _fetchStudentsData(); // Refresh the list
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Deleted Successfully")));
                                          },
                                          child: const Text(
                                            "Ok",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: _studentData.length,
              ),
      ),
    );
  }
}
