import 'package:flutter/material.dart';
import 'package:magnijobs_rnr/models/job_type_model.dart';

class EmployerPortalViewModel extends ChangeNotifier {
  String? selectedCountryId;

  bool _showQueryField = false;

  bool get showQueryField => _showQueryField;

  Jobtypes? selctedJobType;

  set showQueryField(bool value) {
    _showQueryField = value;
    notifyListeners();
  }

  void resetState() {
    selectedCountryId = null;
  }
}
