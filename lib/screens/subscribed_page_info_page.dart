import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/screens/packages_/packages_screen.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:magnijobs_rnr/view_models/all_packges_view_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

import '../view_models/my_subscription_view_model.dart';

class SubScribedPackageInfoPage extends StatefulWidget {
  SubScribedPackageInfoPage({Key? key}) : super(key: key);
  static const id = "SubScribedPackageInfoPage";

  @override
  _SubScribedPackageInfoPageState createState() =>
      _SubScribedPackageInfoPageState();
}

class _SubScribedPackageInfoPageState extends State<SubScribedPackageInfoPage> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<MySubscriptionViewModel>(myContext!, listen: false);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              AppColor.whiteColor //or the color you prefer
          ),
      child: SafeArea(
        child: Scaffold(
            appBar: myAppBar(title: "Your subscription", actions: [
              /* const Padding(
              padding: EdgeInsets.all(18.0),
              child: SvgViewer(svgPath: "assets/icons/ic_search.svg"),
            )*/
            ]),
            backgroundColor: AppColor.alphaGrey,
            body: view.mySubScription == null
                ? Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "You are not subscribed to any package",
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).pop();

                              Provider.of<AllPackagesAndPaymentViewModel>(
                                      myContext!,
                                      listen: false)
                                  .getAllPackages(completion: () async {
                                Navigator.of(myContext!)
                                    .pushNamed(PackagesScreen.id);
                              });
                            },
                            child: Text(
                              "Subscribe now?",
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(
                                color: AppColor.primaryBlueColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      space,
                      Center(
                        child: Text(
                          "Your Package",
                          style: AppTextStyles.textStyleBoldTitleLarge,
                        ),
                      ),
                      space,
                      Center(
                        child: Text(
                          view.myPackage?.name ?? 'N/A',
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                      ),
                      space,
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SimpleRichText(
                            view.myPackage?.details ?? 'N/A',
                            style: AppTextStyles.textStyleNormalBodySmall,
                          ),
                        ),
                      ),
                      space,
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Button(
                            buttonText: 'Change Package',
                            textStyle: AppTextStyles.textStyleNormalBodySmall
                                .copyWith(color: AppColor.whiteColor),
                            onTap: () async {
                              Navigator.of(context).pop();

                              Provider.of<AllPackagesAndPaymentViewModel>(
                                      myContext!,
                                      listen: false)
                                  .getAllPackages(completion: () {
                                Navigator.of(myContext!)
                                    .pushNamed(PackagesScreen.id);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
