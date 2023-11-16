import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentInitiator extends StatelessWidget {
  const CommentInitiator({
    super.key, required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
              child: CircleAvatar(
                maxRadius: 50,
                backgroundImage: NetworkImage(
                  user.photoURL!
                ),
              ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Enter a comment here',
                suffixIcon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}