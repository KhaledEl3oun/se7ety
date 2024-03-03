import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/widget/navigatorReplace.dart';
import 'package:se7ety/features/intro/presentation/view/helloView.dart';
import 'package:se7ety/features/patient/home/presentation/navBar.dart';

class splashView extends StatefulWidget {
  const splashView({super.key});

  @override
  State<splashView> createState() => _splashViewState();
}

class _splashViewState extends State<splashView> {
  User? user;
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    Future.delayed(const Duration(seconds: 3), () {
      routingWithReplaceMent(
          context,
          //const onboarding()
          (user != null) ? const navBar() : const WelcomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/splash.png',
        width: 280,
        height: 280,
      )),
    );
  }
}
