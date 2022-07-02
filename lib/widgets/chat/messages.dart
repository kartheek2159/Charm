import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final auth = FirebaseAuth.instance;
        final User? user;
        user = auth.currentUser;
        if (user != null) {
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) =>
                // Text(chatSnapshot.data?.docs[index]['text'] ?? ""),
                MessageBubble(
              chatSnapshot.data?.docs[index]['text'] ?? "",
              chatSnapshot.data?.docs[index]['userId'] == user?.uid,
              chatSnapshot.data?.docs[index]['username'] ?? "",
            ),
            itemCount: (chatSnapshot.data)?.docs.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
