import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/models/chat_model.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController chatSendTextController = TextEditingController();

  List<ChatModel> listOfChat = [];
}
