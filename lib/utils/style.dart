import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color secondaryColor = Color.fromRGBO(0, 163, 224, 1);
const Color primaryColor = Color.fromRGBO(0, 61, 165, 1);
const Color gray0 = Color.fromRGBO(0, 0, 0, 1);
const Color gray1 = Color.fromRGBO(51, 51, 51, 1);
const Color gray2 = Color.fromRGBO(79, 79, 79, 1);
const Color gray3 = Color.fromRGBO(130, 130, 130, 1);
const Color gray4 = Color.fromRGBO(189, 189, 189, 1);
const double todayWeatherTemperatureFontSize = 22;
const double todayWeatherStringFontSize = 15;
const double hourlyWeatherTimeFontSize = 18;
const double hourlyWeatherTemperatureFontSize = 18;
const double weeklyWeatherFontSize = 17;

///app seeting text Style
TextStyle appSetting = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

///바텀 네비게이션바 텍스트 스타일
TextStyle bottomNavStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

///시설설정 텍스트 사이즈
TextStyle fontSize18 = TextStyle(fontSize: 18);

///appbar, dropdown 텍스트 색낄
TextStyle blackColor = TextStyle(color: Colors.black);

///흰색깔 부분들
TextStyle whiteColor = TextStyle(color: Colors.white);

///빨간글짜 부분들
TextStyle redColor = TextStyle(color: Colors.red);

final f = DateFormat('yyyy년 MM월 dd일');
final journal_date = DateFormat('yyyy.MM');

TableBorder tableBorder = TableBorder(
  horizontalInside: BorderSide(
      style: BorderStyle.solid,
      width: 1,
      color: Color.fromRGBO(242, 242, 242, 100)),
);

InputDecoration inputContent = InputDecoration(
  labelStyle: body2_2,
  hintText: '내용을 입력해주세요',
  enabledBorder:
  UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  focusedBorder:
  UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
);

///전반적인 divider들의 형식
Divider standard_divider = Divider(
  height: 0,
  color: Color.fromRGBO(242, 242, 242, 1),
);

TextStyle h1 = TextStyle(
  fontSize: 20,
  letterSpacing: -0.015,
  fontWeight: FontWeight.bold,
  color: gray1,
);

TextStyle h2 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: gray1,
);

TextStyle h3 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: gray1,
);

TextStyle h4 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

TextStyle h5 = TextStyle(
  fontSize: 28,
  color: Colors.black,
  fontWeight: FontWeight.w300,
);

TextStyle subTitle1 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w900,
  color: gray3,
);

TextStyle subTitle2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: -0.015,
  color: gray1,
);

TextStyle subTitle3 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

TextStyle subTitle3_2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: -0.0615,
  color: gray4,
);

TextStyle subTitle4 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  letterSpacing: -0.25,
  color: Color(0xC4C4C4),
);

TextStyle subTitle4_2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.25,
  color: Color(0xC4C4C4),
);

TextStyle body1 = TextStyle(
  fontSize: 20,
  color: gray4,
);

TextStyle body2 = TextStyle(
  fontSize: 16,
  letterSpacing: -0.0615,
  color: gray1,
);

TextStyle body2_2 = TextStyle(
  fontSize: 16,
  letterSpacing: -0.0615,
  color: gray4,
);

TextStyle body3 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: gray1,
);

TextStyle body4 = TextStyle(
  fontSize: 16,
  letterSpacing: -0.0241176,
  color: gray2,
);

TextStyle body4_2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: -0.0241176,
  color: gray2,
);

TextStyle body5 = TextStyle(
  fontSize: 14,
  letterSpacing: -0.0015,
  color: gray2,
);

TextStyle button_1 = TextStyle(
  fontSize: 16,
  height: 23,
  fontWeight: FontWeight.bold,
  letterSpacing: -0.034,
  color: Color(0xC4C4C4),
);

TextStyle button2 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: gray3,
);

TextStyle button3 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);

TextStyle button4 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);

TextStyle button5 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.03,
  color: gray1,
);

TextStyle caption1 = TextStyle(
  fontSize: 12,
  color: primaryColor,
);

TextStyle caption2 = TextStyle(
  fontSize: 14,
  color: gray3,
  fontWeight: FontWeight.normal,
);

TextStyle caption3 = TextStyle(
  fontSize: 14,
  color: Colors.black,
  fontWeight: FontWeight.w300,
);

TextStyle overLine = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);
