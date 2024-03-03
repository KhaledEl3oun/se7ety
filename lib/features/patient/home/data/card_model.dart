import 'package:flutter/material.dart';
import 'package:se7ety/features/auth/data/specializations.dart';

const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);

const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);

const Color purple = Color(0xff8873f4);
const Color purpleLight = Color(0xff9489f4);

const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3);

class cardModel {
  String doctor;
  Color cardBackground;
  Color colorLight;
  cardModel(this.cardBackground, this.colorLight, this.doctor);
}

List<cardModel> cards = [
  cardModel(skyBlue, lightBlue, specialization[0]),
  cardModel(green, lightGreen, specialization[1]),
  cardModel(orange, lightOrange, specialization[2]),
  cardModel(purple, purpleLight, specialization[3]),
  cardModel(skyBlue, lightBlue, specialization[4]),
  cardModel(green, lightGreen, specialization[5]),
  cardModel(orange, lightOrange, specialization[6]),
  cardModel(purple, purpleLight, specialization[7]),
  cardModel(skyBlue, lightBlue, specialization[8]),
   cardModel(green, lightGreen, specialization[9]),

 
];
