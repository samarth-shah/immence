// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immence_app/component/signUpData.dart';
import 'package:immence_app/screens/homeScree.dart';
import 'package:immence_app/screens/login_screen.dart';

import '../component/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? name;
  TextEditingController? phoneNumber;
  bool passwordVisibility = false;
  bool? checkBoxValue = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    email?.dispose();
    password?.dispose();
    name?.dispose();
    phoneNumber?.dispose();
    super.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!.text.trim(),
        password: password!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(context);
  }

  Future createUser(SignUpData user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'immence',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Poppins',
            fontSize: 22,
          ),
        ),
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomeScreen();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 30, 10, 10),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Text(
                                    'Create an account',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                  child: TextFormField(
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                  child: TextFormField(
                                    controller: email,
                                    obscureText: false,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (email) => (email != null &&
                                            !EmailValidator.validate(email))
                                        ? 'Enter a valid email'
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                  child: TextFormField(
                                    controller: phoneNumber,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your number',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: passwordVisibility,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        (value != null && value.length < 6)
                                            ? 'Enter min. 6 characters'
                                            : null,
                                    decoration: InputDecoration(
                                      hintText: 'Please Enter Your Password',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        // color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            passwordVisibility =
                                                !passwordVisibility;
                                          });
                                        },
                                        child: Icon(
                                          !passwordVisibility
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                          color: const Color(0xFF757575),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: checkBoxValue,
                                  onChanged: ((value) {
                                    setState(() {
                                      checkBoxValue = value;
                                    });
                                  }),
                                  activeColor: Colors.grey.shade300,
                                  checkColor: Colors.black,
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 20, 10, 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    final user = SignUpData(
                                      email: email!.text,
                                      name: name!.text,
                                      password: password!.text,
                                      phoneNumber: phoneNumber!.text,
                                    );

                                    createUser(user);
                                    signUp();

                                    email!.clear();
                                    password!.clear();
                                    name!.clear();
                                    phoneNumber!.clear();
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((context) => const SigninScreen()),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 70, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Allready have an account ? ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                ' Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
