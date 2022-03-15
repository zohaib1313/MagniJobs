import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/chat_model.dart';
import 'package:magnijobs_rnr/models/country_and_job_model.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/view_models/chat_view_model.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class ChatScreen extends StatefulWidget {
  Candidates? candidate;

  ChatScreen(this.candidate, {Key? key}) : super(key: key);
  static const id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<ChatViewModel>(myContext!, listen: false);

  @override
  void initState() {
    super.initState();
    view.listOfChat.clear();
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
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const SvgViewer(
                svgPath: "assets/icons/back_arrow_ic.svg",
              ),
              onPressed: () => Navigator.of(myContext!).pop(),
            ),
            backgroundColor: AppColor.whiteColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.asset("assets/images/app_logo_img.png"),
                    ),
                    SizedBox(
                      width: 35.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.candidate?.firstName ?? "",
                            style: AppTextStyles.textStyleBoldBodySmall),
                        Text("Active Now",
                            style: AppTextStyles.textStyleBoldBodySmall
                                .copyWith(
                                    color: AppColor.greenColor,
                                    fontWeight: FontWeight.normal))
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(50.w),
                      child: const SvgViewer(
                          svgPath: "assets/icons/ic_video_call.svg"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(50.w),
                      child: const SvgViewer(
                          svgPath: "assets/icons/ic_audio_call.svg"),
                    )
                  ],
                )
              ],
            ),
          ),
          backgroundColor: AppColor.alphaGrey,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  //  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                    left: 50.w,
                    right: 50.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.alphaGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: view.listOfChat.length,
                        shrinkWrap: true,
                        itemBuilder: (contxt, index) {
                          if (view.listOfChat[index].isSending) {
                            return getChatBubble(BubbleType.sendBubble,
                                view.listOfChat[index].message);
                          } else {
                            return getChatBubble(BubbleType.receiverBubble,
                                view.listOfChat[index].message);
                          }
                        }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                color: AppColor.whiteColor,
                child: Row(
                  children: [
                    const Expanded(
                      child: SvgViewer(
                        height: 30,
                        width: 30,
                        svgPath: "assets/icons/ic_add.svg",
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: view.chatSendTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter your message',
                          hintStyle: AppTextStyles.textStyleNormalBodyXSmall,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: AppColor.alphaGrey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          /*Provider.of<AllJobsViewModel>(myContext!,
                                  listen: false)
                              .getAllJobs(completion: (List<Jobs> jobs) {
                            Navigator.of(myContext!).push(MaterialPageRoute(
                                builder: (context) => JobPostedScreen()));
                          });*/

                          sendMessage();
                        },
                        child: const SvgViewer(
                          height: 30,
                          width: 30,
                          svgPath: "assets/icons/ic_send_message.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getChatBubble(BubbleType bubbleType, String message) {
    if (bubbleType == BubbleType.sendBubble) {
      return ChatBubble(
        clipper: ChatBubbleClipper3(type: bubbleType),
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: AppColor.chatSendColor.withOpacity(0.34),
        shadowColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return ChatBubble(
        clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
        backGroundColor: AppColor.chatReceiveColor.withOpacity(0.34),
        margin: const EdgeInsets.only(top: 20),
        shadowColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  void sendMessage() {
    if (view.chatSendTextController.text.isNotEmpty) {
      view.listOfChat.add(ChatModel(view.chatSendTextController.text, true));
      view.chatSendTextController.clear();
      setState(() {});
    }
  }
}
