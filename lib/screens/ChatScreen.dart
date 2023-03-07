import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lets Chat",
              style: TextStyle(
                letterSpacing: 2,
                fontFamily: "Shantell Sans",
                fontSize: 25,
              )),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Chatroom").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((msg) {
                        return Row(
                          mainAxisAlignment:
                              FirebaseAuth.instance.currentUser!.uid ==
                                      msg['senderId']
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(msg['sentBy']),
                                      Text(
                                        msg['message'],
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList());
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Message",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide:
                                BorderSide(width: 3, color: Colors.black)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide:
                                BorderSide(width: 3, color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      print(messageController.text);
                      Map<String, dynamic> messagePayload = {
                        "message": messageController.text,
                        "sentBy": auth.currentUser!.email,
                        "senderId": auth.currentUser!.uid,
                        "timestamp": DateTime.now(),
                      };
                      await firestore
                          .collection("Chatroom")
                          .add(messagePayload)
                          .then((value) => print('message sent'))
                          .catchError((e) => print(e));
                      messageController.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ));
  }
}
