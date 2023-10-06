import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_info_app/functions/function.dart';
import 'package:student_info_app/screens/model.dart';
import 'package:student_info_app/screens/student%20list.dart';

class StudentData extends StatefulWidget {
  // const StudentData({super.key});
  final Map<String, dynamic> studentData;

  StudentData({
    required this.studentData,
  });

  @override
  State<StudentData> createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  final _rollnoController = TextEditingController();
  final _nameController = TextEditingController();
  final _departmentcontroller = TextEditingController();
  final _phonenoController = TextEditingController();
  File? _selectedImage;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text('StudentData'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => studentList()));
                },
                icon: Icon(Icons.add_box))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.cyan,
                  child: GestureDetector(
                      onTap: () async {
                        File? pickimage = await _pickImageFromCamera();
                        setState(() {
                          _selectedImage = pickimage;
                        });
                      },
                      child: _selectedImage != null
                          ? ClipOval(
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                            )
                          : const Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.white,
                            )),
                ),
                const Text('Name'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                const Text('Department'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Department is required';
                      }
                      return null;
                    },
                    controller: _departmentcontroller,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                const Text('Roll.No'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Roll no is required';
                      }
                      return null;
                    },
                    controller: _rollnoController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                const Text('Phone Number'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone number is required';
                      }
                      return null;
                    },
                    controller: _phonenoController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if (_selectedImage == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('You must select an image'),
                          ));
                        }
                      }

                      final student = StudentModel(
                        rollno: _rollnoController.text,
                        name: _nameController.text,
                        department: _departmentcontroller.text,
                        phoneno: _phonenoController.text,
                        imageurl: _selectedImage != null
                            ? _selectedImage!.path
                            : null,
                      );

                      if (student.rollno.isNotEmpty &&
                          student.name.isNotEmpty &&
                          student.department.isNotEmpty &&
                          student.phoneno.isNotEmpty) {
                        await addstudent(student);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.blue,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(20),
                          content: Text('Data added successfully'),
                        ));
                        _nameController.clear();
                        _departmentcontroller.clear();
                        _phonenoController.clear();
                        _rollnoController.clear();
                        setState(() {
                          _selectedImage = null;
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.all(20),
                          content: Text('Please fill all the fields'),
                        ));
                      }
                    },
                    child: const Text('save'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
