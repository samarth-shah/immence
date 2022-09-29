import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return const Padding(
      padding: EdgeInsets.all(32),
      /* child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signed In as ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                user.email!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 32,
                ),
              )
            ],
          ), */
    );
  }
}
