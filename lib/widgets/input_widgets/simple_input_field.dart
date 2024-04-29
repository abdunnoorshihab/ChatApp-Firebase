import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/utils/validators.dart';


class SimpleInputField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldTitle;
  final String hintText;
  final bool needValidation;
  final String errorMessage;
  final BorderRadius? borderRadius;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final String? suffixText;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final bool? viewOnly;
  final bool? needTitle;
  final TextAlign? textAlign;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Key? itemkey;
  final Function? onValueChange;
  final TextStyle? titleStyle;
  final Widget? prefixWidget;

  final FormFieldValidator<String>? validatorClass;

  const SimpleInputField(
      {super.key,
      this.onValueChange,
      required this.controller,
      required this.hintText,
      required this.needValidation,
      required this.errorMessage,
      this.textInputAction,
      this.inputType,
      this.suffixText,
      this.backgroundColor,
      this.viewOnly,
      required this.fieldTitle,
      this.validatorClass,
      this.needTitle,
      this.textAlign,
      this.prefixIcon,
      this.itemkey,
      this.borderRadius,
      this.hintTextStyle,
      this.inputTextStyle,
      this.titleStyle, this.prefixWidget});

  @override
  State<SimpleInputField> createState() => _SimpleInputFieldState();
}

class _SimpleInputFieldState extends State<SimpleInputField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needTitle ?? true) Text(widget.fieldTitle, style: widget.titleStyle ?? TextDesign().bodyTitle),
        if (widget.needTitle ?? true) const SizedBox(height: 5),
        TextFormField(
          key: widget.itemkey,
          controller: widget.controller,
          keyboardType: widget.inputType ?? TextInputType.text,
          style: widget.inputTextStyle ?? TextDesign().bodySubText,
          textAlign: widget.textAlign ?? TextAlign.start,
          readOnly: widget.viewOnly ?? false,
          decoration: InputDecoration(
            errorStyle: TextDesign().bodyTextExtraSmall.copyWith(fontSize: 11, color: MyColor.red),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? TextDesign().bodyTextSmall.copyWith(color: MyColor.textLightBlack),
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.white,
            suffixText: widget.suffixText != null ? widget.suffixText.toString() : "",
            suffixIcon: null,
            prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon) : null),
            border: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (value) {
            widget.controller.text = value;
          },
          onSaved: (value) {
            widget.controller.text = value!;
          },
          validator: widget.validatorClass ?? ValidatorClass().noValidationRequired,
          onChanged: (value) {
            if (value.isNotEmpty && widget.onValueChange != null) {
              widget.onValueChange!(value);
            }
          },

        ),
      ],
    );
  }
}
