import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  String title;
  String value;

  PrivacyPolicyScreen({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColor.blackColor),
            automaticallyImplyLeading: true,
            backgroundColor: AppColor.whiteColor,
            title: Text(
              title,
              style: AppTextStyles.textStyleBoldBodyMedium,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SimpleRichText(
                value,
                style: AppTextStyles.textStyleNormalBodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
