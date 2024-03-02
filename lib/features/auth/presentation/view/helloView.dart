import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/auth/presentation/view/introViews/loginView.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: .7,
            child: Image.asset(
              'assets/hello.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       opacity: .7,
          //       image: AssetImage(
          //         'assets/welcome-bg.png',
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
            top: 100,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: Text(
                    'اهلا بيك',
                    style: getTitleStyle(fontSize: 38),
                  ),
                ),
                Text(
                  'سجل واحجز عند دكتورك وانت فالبيت',
                  style: getbodyStyle(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 25,
            right: 25,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: appColors.bottonColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'سجل دلوقتي كــ',
                    style:
                        getbodyStyle(fontSize: 18, color: appColors.scaffColor),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const loginView(index: 0),
                              ));
                        },
                        child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 189, 243, 255)
                                    .withOpacity(.7),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'دكتور',
                                style: getTitleStyle(color: Colors.black),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const loginView(index: 1),
                              ));
                        },
                        child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 189, 243, 255)
                                    .withOpacity(.7),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'مريض',
                                style: getTitleStyle(color: Colors.black),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
