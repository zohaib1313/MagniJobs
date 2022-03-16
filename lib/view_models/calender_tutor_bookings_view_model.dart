import 'package:flutter/material.dart';

class CalenderTutorBookingsViewMode extends ChangeNotifier {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController selectedTimeController = TextEditingController();
  TextEditingController examTypeController = TextEditingController();
  TextEditingController examSubTypeController = TextEditingController();

  void resetDate() {
    selectedTimeController.clear();
    selectedDateController.clear();
    examTypeController.clear();
    examSubTypeController.clear();
  }
}
