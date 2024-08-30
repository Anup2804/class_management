import 'package:class_frontend/services/models/auth_model/signup.model.dart';
import 'package:class_frontend/services/provider/student.provider.dart';
import 'package:class_frontend/widgets/global/form.input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _adminName = TextEditingController();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _standard = TextEditingController();
  final _board = TextEditingController();
  final _schoolName = TextEditingController();
  final _subject = TextEditingController(text: "All");
  final _phoneNo = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _adminName.dispose();
    _schoolName.dispose();
    _standard.dispose();
    _phoneNo.dispose();
    _subject.dispose();
    _board.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: SizedBox(
        height: 655,
        width: double.infinity,
        child: Card(
            elevation: 7,
            color: Colors.white,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register Form',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomFormField(
                              controller: _adminName, label: 'AdminName'),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(controller: _fullName, label: 'Name'),
                          SizedBox(
                            height: 12,
                          ),
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
                            height: 12,
                          ),
                          CustomFormField(
                            controller: _password,
                            label: 'Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              // Email regex pattern
                              // final passwordRegex = RegExp(
                              //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');
                              // if (!passwordRegex.hasMatch(value)) {
                              //   return 'Enter a valid password';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(
                              controller: _board, label: 'BoardName'),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(
                              controller: _schoolName, label: 'SchoolName'),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(
                              controller: _standard, label: 'Standard'),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(
                              controller: _subject, label: "SubjectChosen"),
                          SizedBox(
                            height: 12,
                          ),
                          CustomFormField(
                              controller: _phoneNo, label: 'PhoneNo.'),
                          SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final Student user = Student(
                                  fullName: _fullName.text.trim(),
                                  adminName: _adminName.text.trim(),
                                  password: _password.text.trim(),
                                  email: _email.text.trim(),
                                  standard: _standard.text.trim(),
                                  schoolName: _schoolName.text.trim(),
                                  board: _board.text.trim(),
                                  phoneNo: _phoneNo.text.trim(),
                                  subjectChosen: _subject.text
                                      .split(',')
                                      .map((subject) => subject.trim())
                                      .toList(),
                                );

                                try {
                                  await Provider.of<StudentProvider>(context,
                                          listen: false)
                                      .createStudent(user);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Student created successfully!')),
                                  );
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    Navigator.of(context).pushNamed('/');

                                    _formKey.currentState?.reset();
                                  });
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(' $error')),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Submit',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )),
      )),
    ));
  }
}
