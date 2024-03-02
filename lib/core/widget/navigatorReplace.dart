import 'package:flutter/material.dart';

routingWithReplaceMent(context, Widget newView) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => newView,
  ));
}

pushAndRemoveUntil(BuildContext context, Widget newView) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => newView,
      ),
      (route) => false);
}
