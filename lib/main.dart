import 'package:chatroom/firebase_options.dart';
import 'package:chatroom/screens/ChatScreen.dart';
import 'package:chatroom/screens/SigninPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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


