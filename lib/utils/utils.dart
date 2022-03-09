import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';

import '../styles.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach(
      (match) => print("\n********TAGGGG*********\n${match.group(0)}"));
}

String formatAmount(String? amount) {
  return NumberFormat("#,##0.0", "en_US").format(double.parse(amount ?? "0.0"));
}

myAppBar(
    {String? title,
    Color backGroundColor = AppColor.whiteColor,
    List<Widget>? actions,
    BuildContext? context,
    bool goBack = true,
    onBacKTap}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    actions: actions ?? [],
    leading: goBack
        ? IconButton(
            icon: const SvgViewer(
              svgPath: "assets/icons/back_arrow_ic.svg",
            ),
            onPressed:
                onBacKTap ?? () => Navigator.of(context ?? myContext!).pop(),
          )
        : null,
    backgroundColor: backGroundColor,
    title: Text(
      title ?? "",
      style: AppTextStyles.textStyleBoldBodyMedium,
    ),
  );
}

mySwitch(
    {onTap,
    Color? fillColor,
    bool isActive = false,
    Color? checkColor,
    required String message,
    Color? messageColor}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: fillColor ?? AppColor.whiteColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.check,
            size: 15.0,
            color: isActive ? (checkColor ?? Colors.black) : fillColor,
          ),
        ),
        SizedBox(
          width: 50.w,
        ),
        Text(
          message,
          style: AppTextStyles.textStyleNormalBodySmall
              .copyWith(color: messageColor ?? AppColor.whiteColor),
        )
      ],
    ),
  );
}

Future<void> showDatePickerDialog(
    {required BuildContext context,
    required Function(dynamic date) onDateSelected,
    DatePickerMode initialDatePickerMode = DatePickerMode.day}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: initialDatePickerMode,
      initialDate: DateTime.now(),
      firstDate: DateTime(1905),
      lastDate: DateTime(3905));
  if (picked != null && picked != DateTime.now()) {
    onDateSelected(DateFormat('yyyy-MM-dd').format(picked));
  }
}

Future<void> showMyTimePicker(
    {required BuildContext context,
    required Function(dynamic date) onTimeSelected,
    TimePickerEntryMode initialDatePickerMode =
        TimePickerEntryMode.dial}) async {
  final TimeOfDay? picked =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (picked != null) {
    onTimeSelected(picked.period.name);
  }
}
