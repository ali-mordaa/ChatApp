import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CastumButon extends StatelessWidget {
  const CastumButon({super.key, this.text, this.onTap});
  final VoidCallback? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          text!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
