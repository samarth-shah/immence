import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immence_app/component/signUpData.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  Widget buildUser(SignUpData user) {
    final curUser = FirebaseAuth.instance.currentUser!;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 236, 241, 243),
        child: Text(
          user.name.substring(0, 1).toUpperCase(),
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: curUser.email == user.email
          ? const Icon(
              Icons.circle,
              color: Colors.blue,
              size: 12,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    Stream<List<SignUpData>> readUsers() => FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => SignUpData.fromJson(
                doc.data(),
              ),
            )
            .toList());

    return StreamBuilder<List<SignUpData>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          return ListView(
            children: users.map(buildUser).toList(),
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
