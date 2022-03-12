import 'package:flutter/material.dart';

class EmployerPortalViewModel extends ChangeNotifier {
  TextEditingController queryEditingController = TextEditingController();
  String? selectedCountryId;

  void resetState() {
    queryEditingController.clear();
    selectedCountryId = null;
  }
}
