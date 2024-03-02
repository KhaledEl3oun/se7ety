import 'package:flutter/material.dart';

routing(context, Widget newView) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => newView,
  ));
}
