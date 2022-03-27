import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/common_widgets/app_popups.dart';
import 'package:magnijobs_rnr/common_widgets/common_widgets.dart';
import 'package:magnijobs_rnr/models/chat_model.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/view_models/chat_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes.dart';

class ChatScreen extends StatefulWidget {
  static const id = "ChatScreen";
  String otherUserName;
  String otherUserId;
  String otherUserImage;
  String otherUserPhone;

  ChatScreen(
      {required this.otherUserName,
      required this.otherUserId,
      required this.otherUserImage,
      required this.otherUserPhone});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<ChatViewModel>(myContext!, listen: false);

  final String fromUserId =
      (UserDefaults.getEmployerUserSession()?.user?.id ?? -1).toString();
  var groupId = '';

  @override
  void initState() {
    view.listScrollController = ScrollController();

    if (fromUserId.hashCode <= widget.otherUserId.hashCode) {
      groupId == '$fromUserId-${widget.otherUserId}';
    } else {
      groupId == '${widget.otherUserId}-$fromUserId';
    }
    super.initState();
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
                        Text(widget.otherUserName,
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
                    /*   Padding(
                      padding: EdgeInsets.all(50.w),
                      child: const SvgViewer(
                          svgPath: "assets/icons/ic_video_call.svg"),
                    ),*/
                    InkWell(
                      onTap: () {
                        dialNumber(
                            context: context,
                            phoneNumber: widget.otherUserPhone);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(50.w),
                        child: const SvgViewer(
                            svgPath: "assets/icons/ic_audio_call.svg"),
                      ),
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Messages')
                          .doc(fromUserId)
                          .collection(widget.otherUserId)
                          .orderBy('timeStamp', descending: true)
                          .limit(view.limit)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            controller: view.listScrollController,
                            physics: const BouncingScrollPhysics(),
                            reverse: true,
                            itemBuilder: (contxt, index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>;
                              ChatModel chatModel = ChatModel.fromMap(data);
                              if (chatModel.type == 0) {
                                return textType(chatModel);
                              } else if (chatModel.type == 1) {
                                //image
                                return _loadImage(chatModel);
                              } else {
                                //file
                                return InkWell(
                                  onTap: () {
                                    view.launchUrl(chatModel);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        chatModel.fromId == fromUserId
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 500.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            color: AppColor.blackColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.all(10),
                                        child: Center(
                                          child: Text('File',
                                              style: AppTextStyles
                                                  .textStyleBoldBodyMedium),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                color: AppColor.whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          view.pickFileAndSendMessage(
                              fromUserId: fromUserId,
                              otherUserMobile: widget.otherUserPhone,
                              otherUserImage: widget.otherUserImage,
                              otherUserName: widget.otherUserName,
                              toId: widget.otherUserId);
                        },
                        child: const SvgViewer(
                          height: 30,
                          width: 30,
                          svgPath: "assets/icons/ic_add.svg",
                        ),
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

  Widget getChatBubble(BubbleType bubbleType, String message) {
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
      view.sendMessage(
          otherUserPhone: widget.otherUserPhone,
          otherUserName: widget.otherUserName,
          otherUserImage: widget.otherUserImage,
          mode: ChatModel(
              message: view.chatSendTextController.text,
              fromId: fromUserId,
              toId: widget.otherUserId,
              timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
              //var dt = DateTime.fromMillisecondsSinceEpoch(millis);
              type: 0));

      /* view.listOfChat.add(ChatModel(view.chatSendTextController.text, true));
      view.chatSendTextController.clear();
      setState(() {});*/
    }
  }

  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      AppPopUps.showSnackvBar(
          message: "Unable to call $phoneNumber", context: context);
    }

    return;
  }

  Widget textType(ChatModel chatModel) {
    if (chatModel.fromId == fromUserId) {
      return getChatBubble(BubbleType.sendBubble, chatModel.message);
    } else {
      return getChatBubble(BubbleType.receiverBubble, chatModel.message);
    }
  }

  Widget _loadImage(ChatModel chatModel) {
    return Row(
      mainAxisAlignment: chatModel.fromId == fromUserId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          color: AppColor.alphaGrey,
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.5,
          height: 300.h,
          child: CachedNetworkImage(
            imageUrl: chatModel.message,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
        ),
      ],
    );
  }
}
