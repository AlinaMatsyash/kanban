import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  const AuthField(
      {Key? key, this.onChanged, this.validator, this.initialValue = '', this.hintText = ''})
      : super(key: key);

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String initialValue;
  final String hintText;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: widget.onChanged,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        //labelText: 'Email Address',
        hintText: widget.hintText,
        //hintText: 'Enter your username',
        hintStyle: TextStyle(color: Color(0xff424242)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xff63ffd8))),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xff424242))),
      ),
      validator: widget.validator,
    );
  }
}
