import 'package:flutter/material.dart';

class customTextFormField extends StatefulWidget {
  String hinTxt;
  bool isPasssword;
  String? Function(String?) onValidate;
  void Function(String?) onSaved;

  customTextFormField(
      {super.key,
      required this.hinTxt,
      required this.isPasssword,
      required this.onValidate,
      required this.onSaved});

  @override
  State<customTextFormField> createState() => _customTextFormFieldState();
}

class _customTextFormFieldState extends State<customTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          hintText: widget.hinTxt,
        ),
        obscureText: widget.isPasssword,
        validator: widget.onValidate,
        onSaved: widget.onSaved,
      ),
    );
  }
}
