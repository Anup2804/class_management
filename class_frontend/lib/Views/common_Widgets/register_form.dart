import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Models/student_model.dart';
import 'package:class_frontend/Models/teacher_model.dart';
import 'package:class_frontend/Services/Business%20Logic/student_logic.dart';
import 'package:class_frontend/Services/Business%20Logic/teacher_logic.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_login_screen.dart';
import 'package:class_frontend/Views/main_Screens/Teacher/teacher_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final String type;
  const RegisterForm({super.key, required this.type});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final List<FormFieldItem> formItem = [
    FormFieldItem(
      control: TextEditingController(),
      title: 'FullName',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
    ),
    FormFieldItem(
        title: 'AdminEmail',
        control: TextEditingController(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        }),
    FormFieldItem(
      title: 'Email',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Password',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Please enter your password';
        }
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()]).{8,}$')
            .hasMatch(value)) {
          return 'Please enter a valid paswword';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Standard',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your standard';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'SchoolName',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your schoolname';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Board',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your board';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'SubjectChosen',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your subjectChosen';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'PhoneNo',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 10) {
          return 'Please enter your phoneNo';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Subject you Teach',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your subject';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Boards you Teach',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your board';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Standard you Teach',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your standard';
        }
        return null;
      },
    ),
    FormFieldItem(
      title: 'Staff',
      control: TextEditingController(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your staff';
        }
        return null;
      },
    ),
  ];

  Future<void> onRegisterTeacher(TeacherDetails teachers) async {
    final teacherRepo = Provider.of<TeacherRepo>(context, listen: false);
    try {
      await teacherRepo.teacherRegister(teachers);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher register successfully!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TeacherLogin()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error')),
      );
    }
  }

  Future<void> onRegisterStudent(StudentDetails student) async {
    final studentRepo = Provider.of<StudentRepo>(context, listen: false);

    try {
      await studentRepo.registerStudent(student);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student register successfully!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentLogin()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedFormItems = widget.type == 'teacher'
        ? [
            formItem[0],
            formItem[1],
            formItem[2],
            formItem[3],
            formItem[9],
            formItem[10],
            formItem[11],
            formItem[12]
          ]
        : [
            formItem[0],
            formItem[1],
            formItem[2],
            formItem[3],
            formItem[4],
            formItem[5],
            formItem[6],
            formItem[7],
            formItem[8]
          ];

    return Column(
      children: [
        Text(
          'Register in GURUKUL',
          style: mediumHeadline,
        ),
        SizedBox(
          height: 10,
        ),
        Form(
            key: _formKey,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: displayedFormItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 65,
                  child: TextFormField(
                    controller: displayedFormItems[index].control,
                    cursorHeight: 22,
                    style: mediumBody,
                    validator: displayedFormItems[index].validator,
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
                          displayedFormItems[index].title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                );
              },
            )),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.type == 'teacher') {
                  List<String> hiredForStandard =
                      formItem[11].control.text.split(',');
                  List<String> hiredForSubject =
                      formItem[9].control.text.split(',');
                  List<String> hiredForBoard =
                      formItem[10].control.text.toUpperCase().split(',');

                  onRegisterTeacher(TeacherDetails(
                      fullName: formItem[0].control.text,
                      adminEmail: formItem[1].control.text,
                      email: formItem[2].control.text,
                      hiredForSubject: hiredForSubject,
                      hiredForStandard: hiredForStandard,
                      hiredForBoard: hiredForBoard,
                      staff: formItem[12].control.text,
                      password: formItem[3].control.text));
                }
                if (widget.type == 'student') {
                  List<String> subjectChosen =
                      formItem[7].control.text.split(',');

                  onRegisterStudent(StudentDetails(
                      fullName: formItem[0].control.text,
                      adminEmail: formItem[1].control.text,
                      email: formItem[2].control.text,
                      password: formItem[3].control.text,
                      standard: formItem[4].control.text,
                      schoolName: formItem[5].control.text,
                      board: formItem[6].control.text.toUpperCase(),
                      subjectChosen: subjectChosen,
                      phoneNo: formItem[8].control.text));
                }
              }
            },
            child: Text('submit'))
      ],
    );
  }
}

class FormFieldItem {
  final TextEditingController control;
  final String title;
  final String? Function(String?) validator;

  FormFieldItem(
      {required this.title, required this.validator, required this.control});
}
