import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, String masseg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        masseg,
      ),
    ),
  );
}
