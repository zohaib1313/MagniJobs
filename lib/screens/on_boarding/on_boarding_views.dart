import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';
import 'package:magnijobs_rnr/utils/app_constants.dart';
import 'package:video_player/video_player.dart';

import '../../styles.dart';

class OnBoardingOurCompanyInfo extends StatefulWidget {
  const OnBoardingOurCompanyInfo({Key? key}) : super(key: key);

  @override
  _OnBoardingOurCompanyInfoState createState() =>
      _OnBoardingOurCompanyInfoState();
}

class _OnBoardingOurCompanyInfoState extends State<OnBoardingOurCompanyInfo> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("Our Company",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            space,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Introduction",
                            message: AppConstants.companyIntro,
                            isExpanded: true)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Goal",
                            message: AppConstants.companyGoals,
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    VideoApp(),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/intro_video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    //_controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
///////////////For Clients//////////

class OnBoardingForClients extends StatefulWidget {
  const OnBoardingForClients({Key? key}) : super(key: key);

  @override
  _OnBoardingForClientsState createState() => _OnBoardingForClientsState();
}

class _OnBoardingForClientsState extends State<OnBoardingForClients> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("For Clients",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title:
                                "Employers, Recruitment Agencies, Placement Agencies",
                            message: AppConstants.employerRecruitmentPlacement,
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benefits",
                            message:
                                "For CLIENTS such as employers and recruitment/placement agencies, the company offers: \n\n•Reduced expenses on recruitment process.\n• High quality and trained applicant.\n• Easy access to and communication with qualified candidates.\n• Flexibility in advertising positions.",
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "How to Navigate",
                            message:
                                '''Sign Up, Sign In, Job Posting, Accessing Country and Job ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Pricing",
                            message: '''SUBSCRIPTION

BASIC MEMBERSHIP - £99

- 1 Job Post
- Set Post End Date
- 10 Saved Contacts
- Email Support

ESSENTIAL MEMBERSHIP - £199

- 3 Job Posts
- Set Post End Date
- 20 Saved Contacts
- Email Support

PREMIERE MEMBERSHIP - £299

- 5 Job Posts
- Set Post End Date
- 50 Saved Contacts
- Email Support

EXCLUSIVE MEMBERSHIP - £499

- 5 Job Posts
- HIGHLIGHTED Job Postings (More Visibility)
- Set End Date
- 50 Saved Contacts 
- Chat and Email Support
                            ''',
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///////////////For Applicants//////////

class OnBoardingForApplicant extends StatefulWidget {
  const OnBoardingForApplicant({Key? key}) : super(key: key);

  @override
  _OnBoardingForApplicantState createState() => _OnBoardingForApplicantState();
}

class _OnBoardingForApplicantState extends State<OnBoardingForApplicant> {
  final space = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 100.w, right: 100.w, top: 100.h),
        color: AppColor.primaryBlueColor,
        child: Column(
          children: [
            Text("For Applicants",
                style: AppTextStyles.textStyleBoldTitleLarge
                    .copyWith(color: AppColor.whiteColor)),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    space,
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Job Seekers",
                            message:
                                '''Job seekers from across the world can benefit from this App, with communication
with clients and usage incredibly easy. With the MAGNIJOBS App, it is possible
to maintain visibility to all clients on the App and thus receive multiple offers. We
offer a video on how to navigate the App for applicants so that they can start
finding jobs fitting their skills as soon as possible ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Benefits",
                            message:
                                '''For APPLICANTS, the company’s services are:
• Easy to use and communicate with clients.
• Allow applicants to receive multiple offers 
  from clients.
• Increased visibility.
• Applicants have the option to apply for an
  advertised job or just stand by until a client 
  shows interest in their profile.  ''',
                            isExpanded: false)),
                    space,
                    ExpandAbleTile(
                        model: ExpandableTileModel(
                            title: "Free to Use",
                            message:
                                '''The APP is free to use for all Job Seekers. Just sign up, sign in, then you’re ready to
explore. There will be free access to exam tutors as well. Tutors like for example but
not limited to IELTS FOR UKVI, OET, CBT, NCLEX and other exams necessary for
a job application abroad.
The APP will cater as a site for other service providers which include Emergency
Loan, Recruitment Companies, Food Delivery, Groceries and other useful websites
for our everyday need''',
                            isExpanded: false)),
                    space,
                    space,
                    space,
                    space,
                    space,
                    space,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class VideoDetails extends StatefulWidget {
  const VideoDetails({Key? key}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late InAppWebViewController webView;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url =
      "https://drive.google.com/file/d/1iZ25Op-mVmle2njuN3H9voHsOKwbwMFD/view";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://drive.google.com/file/d/1iZ25Op-mVmle2njuN3H9voHsOKwbwMFD/view")),
              initialOptions: _options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                // var uri = navigationAction.request.url!;

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = this.url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
      ),
      */ /* ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              webViewController?.goBack();
            },
          ),
          ElevatedButton(
            child: Icon(Icons.arrow_forward),
            onPressed: () {
              webViewController?.goForward();
            },
          ),
          ElevatedButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
          ),*/ /*
    ]);
  }
}*/
