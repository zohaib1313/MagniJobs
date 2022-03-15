import 'package:flutter/material.dart';

class EmployerPortalViewModel extends ChangeNotifier {
  TextEditingController queryEditingController = TextEditingController();
  String? selectedCountryId;

  bool _showQueryField = false;

  bool get showQueryField => _showQueryField;

  set showQueryField(bool value) {
    _showQueryField = value;
    notifyListeners();
  }

  void resetState() {
    queryEditingController.clear();
    selectedCountryId = null;
  }
}
