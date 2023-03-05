import 'dart:math';

import 'package:chatroom/screens/ChatScreen.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final loginFromKey = GlobalKey<FormState>();
  String? emailId;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lets Chat",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Shantell Sans"),),

            Form(
              key: loginFromKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "xyz@gmail.com",
                          border: OutlineInputBorder()
                      ),
                      validator: (email) {
                        if (!email!.contains("@")) {
                          return "Invalid EmailID";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (email) => emailId = email,

                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder()
                      ),
                      validator: (password) {
                        if (password!.length < 8) {
                          return "Weak Password";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) => password = pass,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 150, vertical: 15)
                        ),
                        onPressed: () {
                          if (loginFromKey.currentState!.validate()) {
                            loginFromKey.currentState!.save();
                            print(emailId);
                            print(password);
                            Navigator.of(context)
                                .pushReplacement(
                                MaterialPageRoute(builder: (_) => ChatScreen()));
                          }
                        },
                        child: Text("Login")),
                  )
                ],
              ),
            )
          ],
        ),)
      ,
    );
  }
}
