import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/utils/validators.dart';


class PasswordInputField extends StatefulWidget {
  final TextEditingController password;
  final String fieldTitle;
  final String hintText;
  final Color? backgroundColor;
  final TextInputAction? textInputAction;

  const PasswordInputField({
    super.key,
    required this.password,
    required this.fieldTitle,
    required this.hintText,
    this.textInputAction,
    this.backgroundColor,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {

  bool hidePassword = true;
  bool hasSomePassword = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldTitle, style: TextDesign().bodyTitle),
        const SizedBox(height: 5),
        TextFormField(
          autofocus: false,
          obscureText: hidePassword,
          controller: widget.password,
          style: TextDesign().bodyTextSmall,
          onFieldSubmitted: (value) {
            widget.password.text = value;
          },
          onChanged: (value) {
            if (widget.password.text.isNotEmpty) {
              setState(() {
                // FocusScope.of(context).requestFocus();
                hasSomePassword = true;
              });
            } else {
              setState(() {
                hasSomePassword = false;
              });
            }
          },
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          validator: ValidatorClass().validatePassword,
          decoration: InputDecoration(
            focusColor: MyColor.primary,
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.white,
            suffixIcon: hasSomePassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: !hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  )
                : const Icon(Icons.add ,color: Colors.transparent),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            hintText: widget.hintText,
            hintStyle: TextDesign().bodyTextSmall,
            errorStyle: TextDesign().bodyTextExtraSmall.copyWith(fontSize: 11, color: MyColor.red),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
