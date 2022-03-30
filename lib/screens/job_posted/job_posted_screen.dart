import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/models/all_jobs_model.dart';
import 'package:magnijobs_rnr/routes.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/view_models/all_jobs_view_model.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_widgets.dart';
import '../../profile_settting_screen.dart';
import '../../utils/my_app_bar.dart';
import '../../utils/utils.dart';
import '../../view_models/job_post_view_model.dart';
import '../job_post/job_post_screen.dart';

class JobPostedScreen extends StatefulWidget {
  static const id = "JobPostedScreen";

  JobPostedScreen({Key? key}) : super(key: key);

  @override
  _JobPostedScreenState createState() => _JobPostedScreenState();
}

class _JobPostedScreenState extends State<JobPostedScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<AllJobsViewModel>(myContext!);

  @override
  void initState() {
    super.initState();

    view.searchJobPostedController.addListener(() {
      view.searchJobPosted();
    });
  }

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
          appBar: myAppBar(title: "Jobs Posted", actions: [
            MyAnimSearchBar(
              width: MediaQuery.of(context).size.width,
              onSuffixTap: () {
                view.searchJobPostedController.clear();
              },
              closeSearchOnSuffixTap: true,
              textController: view.searchJobPostedController,
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  Navigator.of(myContext!).push(MaterialPageRoute(
                      builder: (context) => ProfileSettingScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: SvgViewer(svgPath: "assets/icons/ic_settings.svg"),
                ),
              ),
            )
          ]),
          backgroundColor: AppColor.alphaGrey,
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                space,
                space,
                space,
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    view.filterJobsOnDate();
                                  },
                                  child: Text(
                                    "Recent",
                                    style:
                                        AppTextStyles.textStyleBoldBodyMedium,
                                  ),
                                ),
                              ),
                            ),
                            Icon(view.isRecentFilterd
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.w, right: 40.w),
                        color: AppColor.alphaGrey,
                        width: 2,
                        height: 50.h,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            view.isSortFiltered
                                ? Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_upward,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.arrow_downward,
                                        size: 20,
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_downward,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.arrow_upward,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  view.filterJobsOnSort();
                                },
                                child: Text(
                                  "Sort",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.w, right: 40.w),
                        color: AppColor.alphaGrey,
                        width: 2,
                        height: 50.h,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.filter_alt_rounded),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialogg();
                                },
                                child: Text(
                                  "Filter",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                space,
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: view.filteredJobs.length,
                      itemBuilder: (context, index) {
                        return getRowJob(
                            job: view.filteredJobs[index], context: context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getRowJob({required Jobs job, context}) {
    return InkWell(
      onTap: () {
        AppPopUps.showThreeOptionsDialog(
            yesTitle: 'Update',
            onYes: () {
              Navigator.pop(context);

              Provider.of<JobPostViewModel>(myContext!, listen: false)
                  .resetState(
                      job: job.job ?? '',
                      location: job.location,
                      countryId: job.country?.toString() ?? '',
                      jobDesc: job.jobDescription ?? '',
                      qulification: job.qualification ?? '',
                      dueDate: job.due_date ?? '',
                      salary: job.salary ?? '');
              Provider.of<JobPostViewModel>(myContext!, listen: false)
                  .getAllCompanies(
                completion: () async {
                  await Navigator.of(myContext!).push(
                    MaterialPageRoute(
                      builder: (context) => JobPostScreen(
                        selectedCountryId: job.location ?? '',
                        updateId: job.id,
                      ),
                    ),
                  );
                  view.getAllJobs(completion: (aa) {
                    setState(() {});
                  });
                },
              );
            },
            noTitle: 'Delete',
            onNo: () {
              Navigator.pop(context);

              view.deleteJob(job, completion: () {
                AppPopUps.showSnackvBar(
                    message: 'Job Deleted', context: context);
                setState(() {});
              });
            },
            nutralTitle: 'Cancel',
            message: 'Choose Action');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(50.r),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/images/jobs_ic.png",
                  ),
                )),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(top: 45.r, left: 20.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.job ?? "",
                        style: AppTextStyles.textStyleBoldBodyMedium,
                      ),
                      Text(
                        job.location ?? "",
                        style: AppTextStyles.textStyleBoldBodyMedium
                            .copyWith(color: AppColor.primaryBlueColor),
                      ),
                      Text(
                        "\€ ${job.salary ?? ""}/ Year",
                        style: AppTextStyles.textStyleBoldBodyMedium
                            .copyWith(color: AppColor.primaryBlueColor),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  int selected = 1;

  void showDialogg() {
    showDialog(
        context: myContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Apply Filter ',
              style: AppTextStyles.textStyleNormalBodyMedium,
            ),
            content: Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });

                      Navigator.pop(context);
                      view.getMyJobs(completion: (aa) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selected == 1
                            ? AppColor.greenColor
                            : AppColor.alphaGrey,
                      ),
                      child: Text(
                        'My Job',
                        style: TextStyle(
                            color: selected == 1
                                ? AppColor.whiteColor
                                : AppColor.blackColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                      Navigator.pop(context);
                      view.getAllJobs(completion: (aa) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selected == 2
                            ? AppColor.greenColor
                            : AppColor.alphaGrey,
                      ),
                      child: Text(
                        'All Job',
                        style: TextStyle(
                            color: selected == 2
                                ? AppColor.whiteColor
                                : AppColor.blackColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.alphaGrey,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.blackColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
