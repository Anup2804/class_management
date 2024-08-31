import 'package:class_frontend/pages/tabs/home.tab.dart';
import 'package:class_frontend/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 90,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor:backGroundColor ,
        elevation: 3,
        title: Text('Dashboard'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   color: Colors.blue,
          // ),
          HomeGrid()],
      )),
    );
  }
}
