import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info_app/functions/function.dart';
import 'package:student_info_app/screens/model.dart';

class studentDetails extends StatefulWidget {
  final Map<String, dynamic> studentData;

  studentDetails({
    required this.studentData,
  });

  @override
  State<studentDetails> createState() => _studentDetailsState();
}

class _studentDetailsState extends State<studentDetails> {
  late Map<String, dynamic> _studentData;

  @override
  void initState() {
    super.initState();
    _studentData = Map.from(widget.studentData);
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = _studentData['imageurl'];
    final String name = _studentData['name'];
    final String rollno = _studentData['rollno'];
    final String department = _studentData['department'];
    final String phonenoDouble = _studentData['phoneno'];

    int phoneno = int.parse(phonenoDouble);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Details of $name'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      imageUrl != null ? FileImage(File(imageUrl)) : null,
                  child: imageUrl == null ? const Icon(Icons.person) : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 239, 100), Color.fromARGB(255, 198, 45, 45)] ),borderRadius: BorderRadius.circular(40)
                      ),
                  height: 300,
                  width: 270,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$name',
                        style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Department: $department',
                          style:
                              TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('phone no: $phoneno',
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Roll No: $rollno',
                          style:
                              TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showEditDialog();
                    },
                    child: const Text('Edit'),
                  ),
                 
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
   void _showEditDialog() async {
    final TextEditingController nameController =
        TextEditingController(text: _studentData['name']);
    final TextEditingController rollnoController =
        TextEditingController(text: _studentData['rollno'].toString());
    final TextEditingController departmentController =
        TextEditingController(text: _studentData['department']);
    final TextEditingController phonenoController =
        TextEditingController(text: _studentData['phoneno'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color.fromARGB(255, 52, 52, 62),
              title: const Text(
                "Edit Student",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.lightBlue),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: rollnoController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Roll number',
                        labelStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.lightBlue),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: departmentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Department',
                        labelStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.lightBlue),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: phonenoController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 2, color: Colors.lightBlue),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await updatedStudent(
                      StudentModel(
                        id: widget.studentData['id'],
                        name: nameController.text,
                        rollno: rollnoController.text.toString(),
                        department: departmentController.text,
                        phoneno: phonenoController.text.toString(),
                        imageurl: widget.studentData['imageurl'],
                      ),
                    );
          
                    Navigator.of(context).pop();
          
                    // debugPrint(nameController.text);
                    setState(() {
                      _studentData['name'] = nameController.text;
                      _studentData['rollno'] = int.parse(rollnoController.text).toString();
                      _studentData['department'] = departmentController.text;
                      _studentData['phoneno'] =
                          int.parse(phonenoController.text).toString();
                    });
          
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Changes Updated"),
                      ),
                    );
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
