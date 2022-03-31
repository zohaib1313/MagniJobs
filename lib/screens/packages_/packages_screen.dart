import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/view_models/all_packges_view_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

import '../../repo/stripe_repo.dart';
import '../../routes.dart';
import '../../styles.dart';
import '../sign_in/sign_in_screen.dart';

class PackagesScreen extends StatefulWidget {
  static const id = "PackagesScreen";

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<PackagesScreen> {
  final space = SizedBox(height: 20.h);
  var view =
      Provider.of<AllPackagesAndPaymentViewModel>(myContext!, listen: false);
  late String secretKey, pubKey;
  bool isInProgress = false;
  late Map<String, dynamic> paymentIntentData;

  bool isTermsAccepted = false;

  bool isNonDisclouserAcceepted = false;
  bool isNonRefundAccepted = false;

  bool isOtherDisclaimerAccepted = false;

  @override
  void initState() {
    _getStripeKey();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getStripeKey() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    await StripeRepo.stripeInfo().then((response) {
      pubKey = response['publish'];
    });

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              left: 100.w, right: 100.w, top: 100.h, bottom: 10.h),
          color: AppColor.primaryBlueColor,
          child: Column(
            children: [
              Text("Packages",
                  style: AppTextStyles.textStyleBoldTitleLarge
                      .copyWith(color: AppColor.whiteColor)),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Column(
                      children: [
                        space,
                        space,
                        ListView.builder(
                            itemCount: view.allPackages?.packages?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  space,
                                  ExpandAbleTile(
                                    isCheckBox: true,
                                    isActiveCheckBox: view
                                            .selectedPaymentMethod ==
                                        (view.allPackages?.packages?[index] ??
                                            false),
                                    onTapCheckBox: () {
                                      view.selectedPaymentMethod =
                                          view.allPackages?.packages?[index];
                                      setState(() {});
                                    },
                                    model: ExpandableTileModel(
                                        title: view.allPackages
                                                ?.packages?[index].name ??
                                            "",
                                        message: view.allPackages
                                                ?.packages?[index].details ??
                                            "".trim(),
                                        isExpanded: false),
                                  ),
                                ],
                              );
                            }),
                        space,
                        Text(
                          "Disclaimers",
                          style: AppTextStyles.textStyleBoldTitleLarge
                              .copyWith(color: AppColor.whiteColor),
                        ),
                        space,
                        ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Terms & Conditions", isExpanded: false),
                          expandedWidgetChild: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SimpleRichText(
                                              '''Your submission of information, including personal information, is governed by the terms of our privacy policy as updated from time to time, and any additional privacy notice issued by your employer.
We grant you a non-exclusive, non-transferable, non-sublicensable, personal, limited, revocable license to use the App for the purpose of gaining employment with one of our clients. Any other use of the App is strictly prohibited. We reserve all rights in and to the App, and we reserve the right to revoke this license at any time, in our sole discretion. 
You may nor rent, lease, sub-license, or translate the App in any way, and may not make any alterations to or modifications of the whole or any part of the App, or permit the App or any part if it is to be combined with or become incorporated in, any other programs.
You agree not to use the App in any unlawful manner, for any unlawful, or criminal purpose, or in any manner inconsistent with these terms, and not to use the App to record, post, or transmit any information that is defamatory, threatening, abusive, offensive, obscene, indecent, discriminatory, or otherwise objectionable. You also agree not to use the App in any way that could damage, impair, or compromise our systems or security or interfere with other users, or restrict or inhibit any other users from using the App, and you agree not to collect or harvest any information or data from the App or its systems, including, without limitation, by using any robot, spider, or other manual or automatic device to retrieve, index, “scrape”, “data mine”, or in any way father App content without our prior written consent.
''',
                                              style: AppTextStyles
                                                  .textStyleNormalBodySmall
                                                  .copyWith(
                                                color: AppColor.whiteColor,
                                              )),
                                          space,
                                          InkWell(
                                            onTap: () {
                                              isTermsAccepted =
                                                  !isTermsAccepted;
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8.r),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: isTermsAccepted
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 15.0,
                                                          color: Colors.black,
                                                        )
                                                      : const Icon(
                                                          null,
                                                          size: 15.0,
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                ),
                                                Text(
                                                  "Agree",
                                                  style: AppTextStyles
                                                      .textStyleNormalBodySmall
                                                      .copyWith(
                                                          color: AppColor
                                                              .whiteColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        space,
                        ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Non-Disclosure Agreement",
                              isExpanded: false),
                          expandedWidgetChild: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                                            style: AppTextStyles
                                                .textStyleNormalBodySmall
                                                .copyWith(
                                                    color: AppColor.whiteColor),
                                          ),
                                          space,
                                          InkWell(
                                            onTap: () {
                                              isNonDisclouserAcceepted =
                                                  !isNonDisclouserAcceepted;
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8.r),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child:
                                                      isNonDisclouserAcceepted
                                                          ? const Icon(
                                                              Icons.check,
                                                              size: 15.0,
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          : const Icon(
                                                              null,
                                                              size: 15.0,
                                                            ),
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                ),
                                                Text(
                                                  "Agree",
                                                  style: AppTextStyles
                                                      .textStyleNormalBodySmall
                                                      .copyWith(
                                                          color: AppColor
                                                              .whiteColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        space,
                        ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "No Refund Policy", isExpanded: false),
                          expandedWidgetChild: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                                            style: AppTextStyles
                                                .textStyleNormalBodySmall
                                                .copyWith(
                                                    color: AppColor.whiteColor),
                                          ),
                                          space,
                                          InkWell(
                                            onTap: () {
                                              isNonRefundAccepted =
                                                  !isNonRefundAccepted;
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8.r),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: isNonRefundAccepted
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 15.0,
                                                          color: Colors.black,
                                                        )
                                                      : const Icon(
                                                          null,
                                                          size: 15.0,
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                ),
                                                Text(
                                                  "Agree",
                                                  style: AppTextStyles
                                                      .textStyleNormalBodySmall
                                                      .copyWith(
                                                          color: AppColor
                                                              .whiteColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        space,
                        ExpandAbleTile(
                          model: ExpandableTileModel(
                              title: "Other Disclaimers", isExpanded: false),
                          expandedWidgetChild: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting in industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500when an unknown printer took a galley of type and scrambled it to make a type or",
                                            style: AppTextStyles
                                                .textStyleNormalBodySmall
                                                .copyWith(
                                                    color: AppColor.whiteColor),
                                          ),
                                          space,
                                          InkWell(
                                            onTap: () {
                                              isOtherDisclaimerAccepted =
                                                  !isOtherDisclaimerAccepted;
                                              setState(() {});
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8.r),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child:
                                                      isOtherDisclaimerAccepted
                                                          ? const Icon(
                                                              Icons.check,
                                                              size: 15.0,
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          : const Icon(
                                                              null,
                                                              size: 15.0,
                                                            ),
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                ),
                                                Text(
                                                  "Agree",
                                                  style: AppTextStyles
                                                      .textStyleNormalBodySmall
                                                      .copyWith(
                                                          color: AppColor
                                                              .whiteColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        space,
                        space,
                        space,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(100.r),
                child: Button(
                  buttonText: "Payment",
                  textColor: AppColor.primaryBlueDarkColor,
                  color: AppColor.whiteColor,
                  onTap: () {
                    if (view.selectedPaymentMethod != null) {
                      if (isTermsAccepted &&
                          isNonDisclouserAcceepted &&
                          isNonRefundAccepted &&
                          isOtherDisclaimerAccepted) {
                        _initiateThePayment(view.selectedPaymentMethod?.id);
                      } else {
                        AppPopUps.showAlertDialog(
                            message: 'Accept All Disclaimers');
                      }
                    } else {
                      AppPopUps.showAlertDialog(message: 'Select Package');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _initiateThePayment(int? packageId) async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    await StripeRepo().payForMySubscription(packageId!).then((response) {
      //print(response);
      paymentIntentData = response.data;
    });

    Stripe.publishableKey = pubKey;
    Stripe.merchantIdentifier = 'MagniJobs';
    await Stripe.instance.applySettings();

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'UK',
            merchantDisplayName: 'MagniJobs'));

    setState(() {});

    displaySheet();

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  Future<void> displaySheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        _updatePayment(paymentIntentData['id']);
        paymentIntentData.clear();

        Navigator.of(myContext!).push(
          MaterialPageRoute(
            builder: (context) => SigInScreen(
              userType: "employer",
            ),
          ),
        );
      });
    } catch (e) {
      AppPopUps.showAlertDialog(message: 'Failed to make the payment.');
    }
  }

  _updatePayment(String paymentID) async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    await StripeRepo.confirmSubscriptionPayment(view.selectedPaymentMethod?.id,
            view.selectedPaymentMethod?.price, paymentID)
        .then((response) {
      AppPopUps.showAlertDialog(message: 'Subscription payment received.');
    });

    setState(() {});

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }
}
