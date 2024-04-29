import '../../../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = FirebaseAuth.instance;
    final firebase = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: StreamBuilder(
        stream: firebase.collection("users").doc(auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData && snapshot.connectionState == ConnectionState.active)
            {
              var user = UserData.fromMap(snapshot.data!.data()!);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(30),
                    child: RandomAvatar(
                      user.name.toString(),
                      trBackground: false,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Name", style: TextDesign().smallTitle.copyWith(color: MyColor.black)),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColor.scaffoldColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            child: Text(
                              snapshot.data!.data()!['name'],
                              style: TextDesign().bodyTextSmall.copyWith(),
                            ),
                          ),

                          const SizedBox(height: 10,),

                          Text("Email", style: TextDesign().smallTitle.copyWith(color: MyColor.black)),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColor.scaffoldColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            child: Text(
                              user.email.toString(),
                              style: TextDesign().bodyTextSmall.copyWith(),
                            ),
                          ),

                        ],
                      )),
                ],
              );
            }
          else
            {
              return const Center(child: CircularProgressIndicator());
            }
        }
      ),
    );
  }
}
