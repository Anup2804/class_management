import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';

class DataForm extends StatelessWidget {
  const DataForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final TextEditingController _name = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  cursorHeight: 22,
                  cursorWidth: 1.5,
                  style: smallBody,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(4),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ],
            ),
          )),
    ));
  }
}
