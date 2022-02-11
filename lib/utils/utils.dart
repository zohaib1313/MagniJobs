import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';

import '../styles.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String formatAmount(String? amount) {
  return NumberFormat("#,##0.0", "en_US").format(double.parse(amount ?? "0.0"));
}

myAppBar({String? title, Color backGroundColor = AppColor.whiteColor}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: SvgViewer(
        svgPath: "assets/icons/back_arrow_ic.svg",
      ),
      onPressed: () => Navigator.of(myContext!).pop(),
    ),
    backgroundColor: backGroundColor,
    title: Text(title ?? "", style: AppTextStyles.textStyleBoldTitleLarge),
  );
}
