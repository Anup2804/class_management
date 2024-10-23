// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final Widget content;
  final double? height;
  final double width;

  const CommonCard({
    super.key,
    required this.content, this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(0.1),
        alignment: FractionalOffset.center,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          width: width,
          height: height ?? 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(5, 5),
                blurRadius: 20,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                offset: Offset(-5, -5),
                blurRadius: 10,
              ),
            ],
          ),
          child: content,
        ));
  }
}
