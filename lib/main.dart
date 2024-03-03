import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety/features/intro/presentation/view/splashView.dart';
import 'package:se7ety/features/auth/presentation/view_model/authCubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDPOk3snzsEhXYnZ_V_oh4NxIjHPHUgeX8",
        appId: "com.example.se7ety",
        messagingSenderId: "63347285901",
        projectId: "se7ty-22151"),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
            fillColor: const Color.fromARGB(255, 155, 210, 255).withOpacity(.7),
            filled: true,
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.cairo().fontFamily),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.red)),
          )),
          builder: (context, child) {
            return Directionality(
                textDirection: TextDirection.rtl, child: child!);
          },
          home: const splashView()),
    );
  }
}
