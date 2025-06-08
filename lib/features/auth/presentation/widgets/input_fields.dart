import 'package:flutter/material.dart';

TextFormField inputFields({
  required BuildContext context,
  required IconData icon,
  required String hintText,
  required String labelText,
  bool obscure = false,
  TextInputType? textInputType,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon: Icon(icon),
      hintText: hintText,
      labelText: labelText,
    ),
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    onSaved: onSaved,
    validator: validator,
    keyboardType: textInputType,
    obscureText: obscure,
  );
}
