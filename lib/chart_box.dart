import 'package:chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chart_messsage.dart';

class Chat_box extends StatelessWidget {
  const Chat_box({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.green.withOpacity(0.3),
          ),
          child: const Column(
            children: [
              Expanded(
                child: ChatMessages(),
              ),
              NewMessage(),
            ],
          ),
        ));
  }
}
