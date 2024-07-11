import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/castume_buton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/castum_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  // commit from ali
  static String id = "loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? email;

  late String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Image.asset("assets/images/scholar.png"),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Scholar Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'pacifico',
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                CastumFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: "email",
                ),
                const SizedBox(
                  height: 12,
                ),
                CastumFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "pasword",
                ),
                const SizedBox(
                  height: 12,
                ),
                CastumButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await userLogin();
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          // ignore: use_build_context_synchronously
                          showSnakBar(context, "No user found for that email.");
                          log(e.code);
                        } else if (e.code == "wrong-password") {
                          // ignore: use_build_context_synchronously
                          showSnakBar(context,
                              "Wrong password provided for that user.");
                          log(e.code);
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showSnakBar(context, "that was an error , try later");
                        log(e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: "Login",
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      // ignore: unnecessary_string_escapes
                      "don\'t have Accaont   ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Color(0xffc7ede6)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
