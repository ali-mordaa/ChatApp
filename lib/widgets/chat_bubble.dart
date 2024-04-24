import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseg_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.masseg,
  });
  final MassegModel masseg;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            color: kPrimaryColor,
          ),
          child: Text(
            masseg.masseg,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ));
  }
}

class ChatBubbleForFrinde extends StatelessWidget {
  const ChatBubbleForFrinde({
    super.key,
    required this.masseg,
  });
  final MassegModel masseg;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16)),
            color: Color(0xff006f93),
          ),
          child: Text(
            masseg.masseg,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ));
  }
}
