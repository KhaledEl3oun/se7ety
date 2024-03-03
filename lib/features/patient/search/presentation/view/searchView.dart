import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class searchView extends StatefulWidget {
  const searchView({super.key});

  @override
  State<searchView> createState() => _searchViewState();
}

class _searchViewState extends State<searchView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColors.bottonColor,
            title: Text(
              'ابحث عن دكتور',
              style: getTitleStyle(color: appColors.scaffColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                            child: Icon(
                              Icons.search,
                              color: appColors.bottonColor,
                            ),
                          ),
                        ),
                        hintText: 'البحث '),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
