import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/features/patient/home/data/card_model.dart';
import 'package:se7ety/features/patient/home/presentation/homeView.dart';

class category extends StatelessWidget {
  const category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'التخصصات',
              style: getbodyStyle(color: appColors.bottonColor, fontSize: 20),
            ),
          ],
        ),
        const Gap(10),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: ItemCardWidget(
                      title: cards[index].doctor,
                      color: cards[index].cardBackground,
                      lightColor: cards[index].colorLight),
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(5);
              },
              itemCount: cards.length),
        ),
      ],
    );
  }
}
