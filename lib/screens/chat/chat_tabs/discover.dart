import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    super.key,
  });

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with WidgetsBindingObserver {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final pageViewController = PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    setStatus('online', DateTime.now());
  }

  void setStatus(String status, DateTime time) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      "status": status,
      "lastOnline": time,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('online', DateTime.now());
    } else {
      setStatus('offline', DateTime.now());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: StreamBuilder(
        stream: firestore.collection('users').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            var userData = snapshot.data.docs;
            return userData.isNotEmpty
                ? ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      var user = userData[index];
                      if (user['uuid'] !=
                          FirebaseAuth.instance.currentUser?.uid) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    RandomAvatar(
                                      user['name'],
                                      trBackground: false,
                                      height: 60,
                                      width: 60,
                                    ),
                                    Positioned(
                                      bottom: 3,
                                      right:
                                          user['status'] == 'offline' ? 0 : 4,
                                      child: user['status'] == 'offline'
                                          ? lastOnline(
                                              (user['lastOnline'] as Timestamp)
                                                  .toDate())
                                          : Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color.fromARGB(
                                                    255, 2, 255, 2),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5),
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user['name'],
                                  style: TextDesign()
                                      .bodyTitle
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: 0, width: 0);
                      }
                      // ListTile(
                      //   title: Text(user['name']),
                      //   subtitle: Text(user['email']),
                      //   // You can add more user details here as needed
                      // );
                    },
                  )
                : const Center(child: Text("No registered users to show"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget lastOnline(DateTime? lastOnline) {
    if (lastOnline == null) {
      return Container();
    }

    final now = DateTime.now();
    final difference = now.difference(lastOnline);

    String timeAgo;

    if (difference.inMinutes < 60) {
      timeAgo = '${difference.inMinutes}min';
    } else if (difference.inHours < 24) {
      timeAgo = '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      timeAgo = '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      timeAgo = '($months)mon';
    } else {
      timeAgo = 'year';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      // height: 15,
      // width: 25,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 227, 248, 209),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        timeAgo,
        style: TextDesign()
            .bodyTitle
            .copyWith(fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}
