import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widget/custom_button.dart';
import 'package:se7ety/core/widget/navigatorReplace.dart';
import 'package:se7ety/features/intro/presentation/widget/onboardingItem.dart';
import 'package:se7ety/features/intro/data/onboarding_model.dart';
import 'package:se7ety/features/intro/presentation/view/helloView.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

List<onboardingModel> pages = [
  onboardingModel(
      image: 'assets/screen1.png',
      text: 'ابحث عن دكتور متخصص',
      body:
          'اكتشف مجموعه واسعه من الاطباء الخبراء والمتخصصين في مختلف المجالات'),
  onboardingModel(
      image: 'assets/screen2.png',
      text: 'سهولة الحجز',
      body: 'احجز المواعيد بضغطة زرار في اي وقت وفي اي مكان'),
  onboardingModel(
      image: 'assets/screen3.png',
      text: 'أمن وسري',
      body: 'كن مطمئنا لان كل خصوصيتك وامانك هما اهم اولوياتنا')
];

var pageController = PageController();
int index = 0;

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: InkWell(
                onTap: () {
                  routingWithReplaceMent(context, const WelcomeView());
                },
                child: Text(
                  'تخطي',
                  style: getbodyStyle(color: appColors.bottonColor),
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: pageController,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return onpboardingItem(model: pages[index]);
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  (index == 2)
                      ? customButton(
                          onPressed: () {
                            routingWithReplaceMent(
                                context, const WelcomeView());
                          },
                          text: 'هيا بنا')
                      : const SizedBox(),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: WormEffect(
                              activeDotColor: appColors.bottonColor,
                              dotHeight: 8)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
