import 'package:chatapp/widgets/chat/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charm'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    Text('Logout'),
                  ],
                ),
              )
            ],
            onChanged: (i) {
              if (i == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/29N0hcDps3dEnsz7IwoM/messages')
              .add({'text': 'this was added by clicking the button'});
        },
      ),
    );
  }
}
