// To parse this JSON data, do
//
//     final messageModel = messageModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<MessageModel> messageModelFromMap(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromMap(x)));

String messageModelToMap(List<MessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MessageModel {
  String? message;
  String? uuid;
  String? name;
  Timestamp? time;

  MessageModel({
    this.message,
    this.uuid,
    this.name,
    this.time,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
    message: json["message"],
    uuid: json["uuid"],
    name: json["name"],
    time: json["time"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "uuid": uuid,
    "name": name,
    "time": time,
  };

  @override
  String toString() {
    return 'MessageModel{message: $message, uuid: $uuid, name: $name, time: $time}';
  }
}
