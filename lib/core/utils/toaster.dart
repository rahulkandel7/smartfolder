import 'package:flutter/material.dart';

showToaster(
    {required BuildContext context,
    required String message,
    Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}
