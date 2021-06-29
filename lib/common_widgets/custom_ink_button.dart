import 'package:flutter/material.dart';

class CustomInkButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomInkButton({
    this.text="",
    // this.color,
    this.borderRadious = 50.0,
    this.height= 50,
    required this.onTap,
    this.width=double.infinity,
    this.condition = true,
  });

  final String text;

  // final Color color;
  final double borderRadious;
  final double height;
  final double width;
  final bool condition;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Color(0xFF1669CB)]),

            borderRadius: BorderRadius.circular(100.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Color.fromRGBO(22, 105, 203, 0.2),
                  offset: Offset(3, 3),
                  blurRadius: 6.0,
                  spreadRadius: 2.0),
              const BoxShadow(
                  color: Color.fromRGBO(22, 105, 203, 0.1),
                  offset: Offset(-3, -3),
                  blurRadius: 6.0,
                  spreadRadius: 2.0),
            ]),
        width: MediaQuery.of(context).size.width*0.8,

        child:  Center(
          child:  Text(
            text,
            style:  TextStyle(
                fontSize: 17.0,
                color: condition ? Colors.white : Colors.grey[400],
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
