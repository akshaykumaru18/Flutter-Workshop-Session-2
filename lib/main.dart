import 'package:chatroom/screens/SigninPage.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Chatroom",
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: SignInPage(),
    );
  }
}


