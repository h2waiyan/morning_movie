import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify your email")),
      body: Center(
          child: Column(
        children: [
          const Text(
              "We've sent you an verification email. Please verify your account to continue."),
          ElevatedButton(
              onPressed: () async {
                User? currentUser = FirebaseAuth.instance.currentUser;

                await currentUser!.reload();
                currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser!.emailVerified == true) {
                  print(">> Go to next screen");
                } else {
                  print("Show Error Message");
                }
                // currentUser.emailVerified
              },
              child: const Text("I've already verified."))
        ],
      )),
    );
  }
}
