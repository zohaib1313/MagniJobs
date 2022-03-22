import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: AppColor.blackColor),
            automaticallyImplyLeading: true,
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Terms & Conditions',
              style: AppTextStyles.textStyleBoldBodyMedium,
            ),
          ),
          body: const Center(
            child: Text('Terms & Conditions Here'),
          ),
        ),
      ),
    );
  }
}
