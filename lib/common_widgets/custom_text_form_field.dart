import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField({
    this.prefix = const SizedBox(),
    this.suffix = const SizedBox(),
    this.labelText = "",
    this.hintText = "",
    this.validator = "",
    this.obscureText = false,
    this.borderRadious = 2.0,
    required this.controller,
    this.maxLines = 1,
    this.minWord=0,
    this.height = 50,
  });

  final Widget prefix;
  final Widget suffix;
  final String labelText;
  final String hintText;
  final String validator;
  final bool obscureText;
  final TextEditingController controller;
  final double borderRadious;
  final int maxLines;
  final int minWord;

  final double height;

  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Color.fromRGBO(22, 105, 203, 0.1),
                  offset: Offset(0, 0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0),
              const BoxShadow(
                  color: Color.fromRGBO(22, 105, 203, 0.1),
                  offset: Offset(0, 0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,

            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              errorStyle: const TextStyle(height: 0,fontSize: 14),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: prefix),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: suffix,
                ),
              ),
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Color(0xFF1669CB),
              ),
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[300]),
            ),
            // onChanged: valueChange,
            validator: (val) {
              if (val!.isEmpty || val.length<minWord) {
                return validator;
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
      ),
    );
  }
}
