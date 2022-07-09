import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.isNumber,
    required this.isPassword,
    required this.size,
    this.readOnly = false,
    required this.onTap,
    required this.validator,
    required this.controller,
  }) : super(key: key);
  IconData icon;
  String hintText;
  bool isPassword;
  bool isNumber;
  String? Function(String?) validator;
  bool readOnly;
  Function() onTap;
  final Size size;
  TextEditingController controller;
  empty() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        validator: validator,
        style: TextStyle(color: Colors.grey.shade800),
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey.shade800,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}
