import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/presentation/widget/category_list.dart';
import 'package:se7ety/features/patient/home/presentation/widget/top_rate_list.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  final TextEditingController _doctorName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_active)),
        title: Text(
          'صحتي',
          style: getTitleStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'مرحبا ,',
                    style: getbodyStyle(fontSize: 18),
                  ),
                  Text(
                    user?.displayName ?? '',
                    style: getbodyStyle(
                        fontSize: 18, color: appColors.bottonColor),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                'احجز الان وكن جزءا من رحلتك الصحيه',
                textAlign: TextAlign.start,
                style: getTitleStyle(fontSize: 29, color: Colors.black),
              ),
              const Gap(20),
              Material(
                elevation: 7,
                shadowColor: appColors.bottonColor,
                borderRadius: BorderRadius.circular(25),
                child: TextFormField(
                  controller: _doctorName,
                  autofocus: false,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: appColors.bottonColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.search,
                              color: appColors.scaffColor,
                            ),
                          ),
                        ),
                      ),
                      hintText: 'ابحث عن دكتور'),
                ),
              ),
              const Gap(20),
              const category(),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'الأعلي تقيما',
                    style: getbodyStyle(
                        color: appColors.bottonColor, fontSize: 20),
                  ),
                ],
              ),
              const Gap(20),
              const topListView()
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.lightColor});
  final String title;
  final Color color;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: lightColor.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: lightColor,
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/card.png',
                    width: 150,
                  ),
                  const Gap(10),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: getTitleStyle(
                          color: appColors.scaffColor, fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
