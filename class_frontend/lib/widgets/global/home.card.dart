import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String url;
  final double scale;
  final String head ;
  final VoidCallback tap; 
  const HomeContainer({super.key, required this.url, required this.scale, required this.head, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(2, 5), blurRadius: 7)
              ]),
          child: InkWell(
            onTap: tap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                url,
                scale: scale,
              ),
            ),
          ),
        ),
        SizedBox(height: 2,),
        Text(head)
      ],
    );
  }
}
