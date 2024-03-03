import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/intro/data/onboarding_model.dart';

class onpboardingItem extends StatelessWidget {
  const onpboardingItem({
    super.key,
    required this.model,
  });
  final onboardingModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        Image.asset(
          model.image,
          height: 290,
          width: 290,
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          model.text,
          style: getTitleStyle(),
        ),
        const Gap(20),
        Text(
          model.body,
          textAlign: TextAlign.center,
          style: getbodyStyle(),
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
