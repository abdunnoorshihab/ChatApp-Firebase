import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/message_model.dart';

class ChatService{
  
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  
  
  Future<void> sendChatMessage({required String message})async{
    var messageModel = MessageModel(
      name: auth.currentUser!.email.toString(),
      message: message,
      uuid: auth.currentUser!.uid.toString(),
      time: Timestamp.now()
    );
    
    await firebase.collection('chat').add(messageModel.toMap());
    
    
  }
  
}