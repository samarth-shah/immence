import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    const url =
        'https://drive.google.com/file/d/1jKpHJD7xvl4q2L6LSZha1JEk8LcLB-kE/view?usp=sharing';
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              url,
            ),
            // backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Name',
            style: TextStyle(
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
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                user.email!,
                style: const TextStyle(
                  // fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
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
                'Phone No.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                user.email!,
                style: const TextStyle(
                  // fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
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
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(Icons.logout),
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
  }
}
