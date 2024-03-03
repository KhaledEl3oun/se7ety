import 'package:flutter/material.dart';

class timeView extends StatefulWidget {
  const timeView({super.key});

  @override
  State<timeView> createState() => _timeViewState();
}

class _timeViewState extends State<timeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('time')),
    );
  }
}
