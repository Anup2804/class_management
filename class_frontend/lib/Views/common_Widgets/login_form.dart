import 'package:class_frontend/Models/Admin/admin_model.dart';
import 'package:class_frontend/Models/Student/student_model.dart';
import 'package:class_frontend/Models/Teacher/teacher_model.dart';
import 'package:class_frontend/Services/Providers/admin_provider.dart';
import 'package:class_frontend/Services/Providers/student_provider.dart';
import 'package:class_frontend/Services/Providers/teacher_provider.dart';
import 'package:flutter/material.dart';

import 'package:class_frontend/Constants/fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final String targetPath;
  final String type;

  const LoginForm({
    super.key,
    required this.targetPath,
    required this.type,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailfocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _emailCursor = true;
  bool _passwordCursor = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _onSubmitStudent() async {
    print(_email.text.trim);
    final StudentDetails students = StudentDetails(
      fullName: '',
      adminEmail: '',
      password: _password.text.trim(),
      email: _email.text.trim(),
      standard: '',
      schoolName: '',
      board: '',
      phoneNo: '',
      subjectChosen: [],
    );
    try {
      await Provider.of<StudentProvider>(context, listen: false)
          .studentLogin(students);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student login successfully!')),
      );
      Navigator.pushNamed(context, widget.targetPath);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error')),
      );
    }
  }

  Future<void> _onSubmitTeacher() async {
    print(_email.text.trim);
    final TeacherDetails teachers = TeacherDetails(
        fullName: '',
        adminEmail: '',
        email: _email.text.trim(),
        password: _password.text.trim(),
        hiredForSubject: [],
        hiredForStandard: [],
        hiredForBoard: [],
        staff: '');
    try {
      await Provider.of<TeacherProvider>(context, listen: false)
          .teacherLogin(teachers);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher login successfully!')),
      );
      Navigator.pushNamed(context, widget.targetPath);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error')),
      );
    }
  }

  Future<void> _onSubmitAdmin() async {
    print(_email.text.trim);
    final AdminDetails admins = AdminDetails(
        adminName: '',
        email: _email.text.trim(),
        password: _password.text.trim());
    try {
      await Provider.of<AdminProvider>(context, listen: false)
          .adminLogin(admins);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher login successfully!')),
      );
      Navigator.pushNamed(context, widget.targetPath);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: largeBody,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    focusNode: _emailfocus,
                    controller: _email,
                    cursorHeight: 22,
                    style: mediumBody,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _emailCursor = false;
                        });
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        setState(() {
                          _emailCursor = false;
                        });
                        return 'Please enter a valid email';
                      }
                      setState(() {
                        _emailCursor = true;
                      });
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        _emailCursor = true;
                      });
                    },
                    showCursor: _emailCursor,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text(
                          'Email',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    focusNode: _passwordFocus,
                    controller: _password,
                    cursorHeight: 22,
                    style: mediumBody,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _passwordCursor = false;
                        });
                        return 'Please enter your password';
                      }
                      if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()]).{8,}$')
                          .hasMatch(value)) {
                        setState(() {
                          _passwordCursor = false;
                        });
                        return 'Please enter a valid paswword';
                      }
                      setState(() {
                        _passwordCursor = true;
                      });
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        _passwordCursor = true;
                      });
                    },
                    showCursor: _passwordCursor,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text(
                          'Password',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.type == 'student') {
                        _onSubmitStudent();
                      } else if (widget.type == 'teacher') {
                        _onSubmitTeacher();
                      } else if (widget.type == 'admin') {
                        _onSubmitAdmin();
                        print('admin login');
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ))
      ],
    );
  }
}
