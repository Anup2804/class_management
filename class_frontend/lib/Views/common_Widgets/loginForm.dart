import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final String targetPath;

  const LoginForm({
    super.key,
    required this.targetPath,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form successfully submitted')),
                      );
                      Navigator.pushNamed(context, widget.targetPath);
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
