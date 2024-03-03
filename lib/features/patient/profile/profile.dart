import 'package:flutter/material.dart';

class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('profile')),
    );
  }
}
