// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immence_app/screens/homeScree.dart';
import 'package:immence_app/screens/signup_screen.dart';

import '../component/utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController? emailTextEditingController;
  TextEditingController? passwordTextEditingController;
  bool passwordVisibility = true;
  bool? checkBoxValue = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextEditingController?.dispose();
    passwordTextEditingController?.dispose();
    super.dispose();
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController!.text.trim(),
        password: passwordTextEditingController!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    Navigator.pop(context);
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
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Has Some Error'),
                );
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return SingleChildScrollView(
                    child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Text(
                                  'Hi, Welcome Back! 👋',
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: TextFormField(
                                  controller: emailTextEditingController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Please Enter Your Email',
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
                                      borderRadius: BorderRadius.circular(10),
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
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: TextFormField(
                                  controller: passwordTextEditingController,
                                  obscureText: passwordVisibility,
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
                                      borderRadius: BorderRadius.circular(10),
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
                                  signIn();
                                },
                                child: const Text(
                                  'Login',
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const SignUpScreen())));
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 230, 10, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                ' Sign Up',
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
                  ),
                ));
              }
            },
          ),
        ));
  }
}
