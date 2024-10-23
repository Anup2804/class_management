import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:flutter/material.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              margin: EdgeInsets.all(5),
               child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset('assets/images/main_logo.jpeg')),
             ),
             
             Text('WELCOME TO GURUKUL',style: mediumHeadline,),
            CommonCard(
              height: 160,
                content: Column(
                  children: [
                   
                    ElevatedButton(
                  
                      onPressed: (){
                      Navigator.pushNamed(context, '/admin/login');
                    }, child: Text('Login as Admin')),
                    ElevatedButton(
                  
                      onPressed: (){
                      Navigator.pushNamed(context, '/teacher/login');
                    }, child: Text('Login as Teacher')),
                    ElevatedButton(
                  
                      onPressed: (){
                      Navigator.pushNamed(context, '/student/login');
                    }, child: Text('Login as Student')),
                  ],
                ),
                width: 250)
          ],
        ),
      ),
    );
  }
}
