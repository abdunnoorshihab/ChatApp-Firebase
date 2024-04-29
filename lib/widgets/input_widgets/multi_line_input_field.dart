import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/utils/validators.dart';



class MultiLineInputField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldTitle;
  final String hintText;
  final String? suffixText;
  final int numberOfLines;
  final Color? backgroundColor;
  final bool? viewOnly;
  final bool? needTitle;
  final FormFieldValidator<String>? validatorClass;
  const MultiLineInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixText,
      this.backgroundColor,
      this.viewOnly,
      required this.fieldTitle,
      this.validatorClass,
      this.needTitle,
      required this.numberOfLines});

  @override
  State<MultiLineInputField> createState() => _MultiLineInputFieldState();
}

class _MultiLineInputFieldState extends State<MultiLineInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needTitle ?? true)
          Text(widget.fieldTitle, style: TextDesign().bodyTitle),
        if (widget.needTitle ?? true) const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          style: TextDesign().bodyTextSmall,
          readOnly: widget.viewOnly ?? false,
          maxLines: widget.numberOfLines,
          decoration: InputDecoration(
            errorStyle: TextDesign()
                .bodyTextExtraSmall
                .copyWith(fontSize: 11, color: MyColor.red),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //label: FocusScope.of(context).focusedChild != null ? Text(widget.hintText) : null,
            hintText: widget.hintText,
            hintStyle: TextDesign()
                .bodyTextSmall
                .copyWith(color: MyColor.textLightBlack),
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.white,
            suffixText:
                widget.suffixText != null ? widget.suffixText.toString() : "",
            suffixIcon: null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.newline,
          onFieldSubmitted: (value) {
            widget.controller.text = value;
          },
          onSaved: (value) {
            widget.controller.text = value!;
          },
          validator:
              widget.validatorClass ?? ValidatorClass().noValidationRequired,
        ),
      ],
    );
  }
}
