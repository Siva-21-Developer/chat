import 'package:chat/chat_user_box.dart';
import 'package:chat/firebaseApi.dart';
import 'package:chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'chart_messsage.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _firebaseMessageing = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessageing.requestPermission();
    _firebaseMessageing.subscribeToTopic('chat');
    //
    // final fToken = await _firebaseMessageing.getToken();
    //
    // print("token : $fToken");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
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
                child: ChatMessagess(),
              ),
            ],
          ),
        ));
  }
}
