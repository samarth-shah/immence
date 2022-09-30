import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/signUpData.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildUser(SignUpData user) {
    final curUser = FirebaseAuth.instance.currentUser!;
    if (user.email == curUser.email) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color.fromARGB(255, 236, 241, 243),
              foregroundImage:
                  NetworkImage('https://picsum.photos/250?image=9'),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              user.name,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Phone No.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  user.phoneNumber,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(
                    Icons.logout,
                    size: 18,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        ),
      );
    } else {
      return const Text(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    // SignUpData user;
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
        });
  }
}
