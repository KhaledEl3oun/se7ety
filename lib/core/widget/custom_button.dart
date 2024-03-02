import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  const customButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = const Color(0xff0B8FAC),
    this.forGround = const Color(0xffffffff),
  });
  final String text;
  final Function() onPressed;
  final Color backGroundColor;
  final Color forGround;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: backGroundColor,
              foregroundColor: forGround,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          onPressed: onPressed,
          child: Text(
            text,
            style: getTitleStyle(color: appColors.scaffColor),
          )),
    );
  }
}
