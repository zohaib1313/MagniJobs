import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const primaryBlueColor = Color(0xff6D55FE);
  static const primaryBlueDarkColor = Color(0xff6046FD);

  static const blackColor = Color(0xff1C2340);
  static const orangeColor = Color(0xffFF7266);
  static const greenColor = Color(0xff2CC78C);
  static const blueColor = Color(0xff0088FF);
  static const accentColor = Color(0xff13CAC3);
  static const redColor = Colors.red;
  static const chatReceiveColor = Color(0xff7F47FA);
  static const chatSendColor = Color(0xffFFC107);

  static const alphaGrey = Color(0xffF5F3F3);
  static const whiteColor = Colors.white;
  static const greyColor = Colors.grey;
}

class AppAssets {
  static const appLogo = "assets/icons/app_logo.svg";
}

class AppTextStyles {
  static final _fontBold = GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColor.blackColor));
  static final _fontNormal = GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: AppColor.blackColor));

  static final TextStyle textStyleBoldTitleLarge =
      _fontBold.copyWith(fontSize: 22);
  static final TextStyle textStyleBoldSubTitleLarge =
      _fontBold.copyWith(fontSize: 20);
  static final TextStyle textStyleNormalLargeTitle =
      _fontNormal.copyWith(fontSize: 20);
  static final TextStyle textStyleBoldBodyMedium =
      _fontBold.copyWith(fontSize: 16);
  static final TextStyle textStyleNormalBodyMedium =
      _fontNormal.copyWith(fontSize: 16);
  static final TextStyle textStyleBoldBodySmall =
      _fontBold.copyWith(fontSize: 14);
  static final TextStyle textStyleNormalBodySmall =
      _fontNormal.copyWith(fontSize: 14);
  static final TextStyle textStyleBoldBodyXSmall =
      _fontBold.copyWith(fontSize: 12);
  static final TextStyle textStyleNormalBodyXSmall =
      _fontNormal.copyWith(fontSize: 12);
}
