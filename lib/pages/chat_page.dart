import 'dart:core';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0, // Adjust color as needed
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Comfort zone ❤️',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            extendBodyBehindAppBar: true, // Make background transparent
            body: Stack(
              children: [
                // Background image (replace with your image path)
                Image.asset(
                  'assets/WhatsApp Image 2024-04-12 at 10.46.19 PM.jpeg', // Replace with your image path
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),

                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index].id == email
                                ? ChatBuble(
                                    message: messagesList[index],
                                  )
                                : ChatBubleForFriend(
                                    message: messagesList[index],
                                  );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(color: Colors.white),
                          controller: controller,
                          onSubmitted: (data) {
                            messages.add({
                              'message': data,
                              'createdAt': DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _controller.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          decoration: InputDecoration(
                            hintText: 'Send Message',
                            hintStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () {
                                var data = controller.text;
                                messages.add({
                                  'message': data,
                                  'createdAt': DateTime.now(),
                                  'id': email,
                                });
                                controller.clear();
                                _controller.animateTo(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                // Background image (replace with your image path)
                Image.asset(
                  'assets/WhatsApp Image 2024-04-12 at 10.46.19 PM (1).jpeg', // Replace with your image path
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),

                const Center(
                  child: Text(
                    'Wait ya wahshany ',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ]));
        }
      },
    );
  }
}
