import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magnijobs_rnr/dio_network/APis.dart';
import 'package:magnijobs_rnr/styles.dart';
import 'package:magnijobs_rnr/utils/user_defaults.dart';
import 'package:magnijobs_rnr/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../view_models/all_chat_view_model.dart';
import 'chat_screen.dart';

class AllChatPage extends StatefulWidget {
  static const id = "AllChatPage";

  const AllChatPage({Key? key}) : super(key: key);

  @override
  _AllChatPageState createState() => _AllChatPageState();
}

class _AllChatPageState extends State<AllChatPage> {
  final space = SizedBox(height: 20.h);
  var view = Provider.of<AllChatViewModel>(myContext!, listen: false);
  String? currentUserId = UserDefaults.getCurrentUserId();

  @override
  void initState() {
    super.initState();
    currentUserId = UserDefaults.getCurrentUserId();
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
          appBar: myAppBar(goBack: true, title: 'Chats'),
          backgroundColor: AppColor.alphaGrey,
          body: currentUserId == null
              ? const Center(
                  child: Text('Something went wrong'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
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
                                .doc(currentUserId!)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Something went wrong'));
                              }
                              if (snapshot.data?.data() == null) {
                                return const Center(
                                    child: Text('No Chat Found'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: Text("Loading"));
                              }
                              Map<String, dynamic> mMap =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              // e.value['name']
                              return ListView(
                                  children: mMap.entries
                                      .toList()
                                      .reversed
                                      .map((e) => Dismissible(
                                            direction:
                                                DismissDirection.startToEnd,
                                            confirmDismiss: (DismissDirection
                                                direction) async {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text("Confirm"),
                                                    content: const Text(
                                                        "Are you sure you wish to delete this item?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          view.deleteChat(
                                                              userId:
                                                                  currentUserId ??
                                                                      '',
                                                              docId:
                                                                  e.value['id'],
                                                              onComplete:
                                                                  (status) {
                                                                return Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        status);
                                                              });
                                                        },
                                                        child: const Text(
                                                            "DELETE"),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: const Text(
                                                            "CANCEL"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            background: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 28.0),
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              color: Colors.red,
                                              child: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.white,
                                              ),
                                            ),
                                            resizeDuration: const Duration(
                                                milliseconds: 200),
                                            key: UniqueKey(),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(myContext!).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                      otherUserId:
                                                          e.value['id'],
                                                      otherUserImage:
                                                          e.value['image'],
                                                      otherUserName:
                                                          e.value['name'],
                                                      otherUserPhone:
                                                          e.value['mobile'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    title:
                                                        Text(e.value['name']),
                                                    trailing: Text(
                                                        view.readTimestamp(
                                                            int.parse(e.value[
                                                                'time']))),
                                                    subtitle: Text(
                                                        e.value['lastMessage']),
                                                    leading: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: e.value[
                                                                  'image'] !=
                                                              ""
                                                          ? Image.network(ApiConstants
                                                                      .employer_logos +
                                                                  e.value[
                                                                      'image'])
                                                              .image
                                                          : const AssetImage(
                                                              'assets/images/place_your_image.png'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget userInfoStreamBuilder(String id) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 19,
      color: AppColor.redColor,
    );
  }
}
