import 'package:chat_application/const_config/text_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../../const_config/color_config.dart';
import '../../../services/chat_service.dart';
import '../../../widgets/input_widgets/simple_input_field.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final firebase = FirebaseFirestore.instance;
  final messageController = TextEditingController();
  late String? currentUserID;
  Map<String, String> userNames = {};

  @override
  void initState() {
    super.initState();
    getCurrentUserID();
    fetchUserNames();
  }

  void getCurrentUserID() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      currentUserID = currentUser.uid;
    }
  }

  Future<void> fetchUserNames() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final users = querySnapshot.docs;
    for (var user in users) {
      userNames[user.id] = user.data()['name'];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firebase.collection('chat').orderBy('time').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.active) {
                    var data = snapshot.data.docs;
                    return data.length != 0
                        ? ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final message =
                                  snapshot.data.docs[index]['message'];
                              final senderID =
                                  snapshot.data.docs[index]['uuid'];
                              final isCurrentUser = senderID == currentUserID;
                              final userName = userNames[senderID] ?? 'Unknown';
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment: isCurrentUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    if (!isCurrentUser)
                                      RandomAvatar(
                                        userName,
                                        trBackground: false,
                                        height: 20,
                                        width: 20,
                                      ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: isCurrentUser
                                            ? MyColor.deepBlue
                                            : const Color.fromARGB(
                                                255, 209, 209, 209),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          message,
                                          style: TextDesign()
                                              .bodyTitle
                                              .copyWith(
                                                  color: isCurrentUser
                                                      ? MyColor.white
                                                      : MyColor.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(child: Text("No Chats to show"));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SimpleInputField(
                    controller: messageController,
                    hintText: "Aa..",
                    needValidation: true,
                    errorMessage: "Message box can't be empty",
                    fieldTitle: "",
                    needTitle: false,
                    inputTextStyle: const TextStyle(color: MyColor.black),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    String messageText = messageController.text;
                    if (messageText.isNotEmpty) {
                      ChatService().sendChatMessage(message: messageText);
                      messageController.clear();
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.circleArrowUp),
                  iconSize: 40,
                  color: MyColor.deepBlue,
                ),
              ],
            ),

            // RoundedActionButton(
            //   onClick: () {

            //   },
            //   label: "",

            //   iconData: Icons.send,
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
