import 'package:class_frontend/services/models/auth_model/signup.model.dart';
import 'package:class_frontend/services/provider/student.provider.dart';
import 'package:class_frontend/widgets/global/form.input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
         Opacity(
      opacity: 0.5, 
      child: Image.asset(
        'assets/images/Teacher.png', 
        fit: BoxFit.cover, 
        height: double.infinity,
        width: double.infinity,
      ),
            ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 7,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomFormField(
                              controller: _email,
                              label: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
      
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                              controller: _password,
                              label: 'Password',
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final Student user = Student(
                                      fullName: '',
                                      adminName: '',
                                      password: _password.text.trim(),
                                      email: _email.text.trim(),
                                      standard: '',
                                      schoolName: '',
                                      board: '',
                                      phoneNo: '',
                                      subjectChosen: [],
                                    );
                                    try {
                                      await Provider.of<StudentProvider>(
                                              context,
                                              listen: false)
                                          .loginStudent(user);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Student login successfully!')),
                                      );
                                      Future.delayed(
                                          const Duration(seconds: 1), () {
                                        Navigator.of(context)
                                            .pushNamed('/home');
      
                                        _formKey.currentState?.reset();
                                      });
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(' $error')),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium,
                                )),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/signup');
                                },
                                child: Text("Click here to Signup",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                                255, 194, 20, 8)
                                            .withOpacity(.8))))
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}