import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required bool failureMessage,
  double? height,
}) {
  final size = MediaQuery.of(context).size;

  var snackBar = SnackBar(
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextDesign().smallTitle.copyWith(color: Colors.white)),
        Text(message, style: TextDesign().bodyTextExtraSmall.copyWith(color: Colors.white), textAlign: TextAlign.center),
      ],
    ),
    backgroundColor: failureMessage ? MyColor.red : MyColor.primary,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    margin: EdgeInsets.only(bottom: size.height - (height ?? 100), left: 20, right: 20),
    elevation: 2,
    duration: const Duration(seconds: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}