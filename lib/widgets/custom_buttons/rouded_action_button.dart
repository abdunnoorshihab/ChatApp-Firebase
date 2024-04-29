// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';


class RoundedActionButton extends StatefulWidget {
  final Function onClick;
  final String label;
  final Color? forGroundColor;
  final double? height;
  final double? width;
  final double? radius;
  final bool? isFilled;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final IconData? iconData;

  const RoundedActionButton(
      {super.key,
      required this.onClick,
      required this.label,
      this.forGroundColor,
      this.backgroundColor,
      this.height,
      this.width,
      this.fontSize,
      this.radius,
      this.borderRadius,
      this.textStyle,
      this.isFilled,
      this.padding, this.iconData});

  @override
  State<RoundedActionButton> createState() => _RoundedActionButtonState();
}

class _RoundedActionButtonState extends State<RoundedActionButton> {
  bool showFilledButton = true;

  @override
  void initState() {
    showFilledButton = widget.isFilled ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          widget.onClick();
        },
        child: Container(
            height: widget.height ?? 45,
            width: widget.width ?? 120,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            decoration: BoxDecoration(
              color: showFilledButton
                  ? widget.backgroundColor ?? MyColor.primary
                  : widget.backgroundColor ?? MyColor.scaffoldColor,
              borderRadius: widget.borderRadius ??
                  BorderRadius.circular(widget.radius ?? 100),
              border: showFilledButton
                  ? Border.all(
                      width: 2,
                      color: widget.forGroundColor ?? MyColor.primary,
                    )
                  : Border.all(width: 0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget.iconData !=null)
                  Icon(widget.iconData ,color: !showFilledButton? MyColor.white : widget.forGroundColor ,size: 20),
                  if(widget.iconData !=null)
                  const SizedBox(width: 5,),
                  Flexible(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: widget.textStyle ??
                          TextDesign().bodyTitle.copyWith(
                              color: widget.forGroundColor ?? MyColor.white,
                              fontSize: widget.fontSize ?? 13),
                    ),
                  ),
                ],
              ),
            )));
  }
}
