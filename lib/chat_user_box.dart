import 'package:chat/chart_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessagess extends StatelessWidget {
  const ChatMessagess({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userAuth = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          final data = snapshots.data!.docs;

          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final chatMessage = data[index].data();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat_box(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(chatMessage['image_url']),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              chatMessage['username'].toString().toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
        return const Text(" No data");
      },
    );
  }
}

