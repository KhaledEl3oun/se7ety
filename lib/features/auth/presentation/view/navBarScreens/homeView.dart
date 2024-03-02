import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_active)),
        title: Text(
          'صحتي',
          style: getTitleStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                  'خالد سعيد',
                  style:
                      getbodyStyle(fontSize: 18, color: appColors.bottonColor),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'التخصصات',
                  style:
                      getbodyStyle(color: appColors.bottonColor, fontSize: 20),
                ),
              ],
            ),
            const Gap(10),
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          color: appColors.bottonColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/card.png',
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(20);
                  },
                  itemCount: 5),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'الأعلي تقيما',
                  style:
                      getbodyStyle(color: appColors.bottonColor, fontSize: 20),
                ),
              ],
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: appColors.bottonColor.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/me.jpg'),
                      radius: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Gap(5),
                        Text(
                          'علي زين خالد',
                          style: getbodyStyle(
                              color: appColors.bottonColor, fontSize: 20),
                        ),
                        Text(
                          'جراحه عامه',
                          style:
                              getbodyStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    const Gap(125),
                    const Text('3'),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
