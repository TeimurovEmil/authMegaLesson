import 'package:flutter/material.dart';

class ProviderAuth with ChangeNotifier {
  final phoneController = TextEditingController();
  final smsController = TextEditingController();
  final isPhoneFilled = ValueNotifier<bool>(false);
  final isSmsFilled = ValueNotifier<bool>(false);
  String token = '';

  void setPhoneFilled() {
    isPhoneFilled.value = true;
    notifyListeners();
  }

  void setNotPhoneFilled() {
    isPhoneFilled.value = false;
    notifyListeners();
  }

  void setSmsFilled() {
    isSmsFilled.value = true;
    notifyListeners();
  }

  void setSmsNotFilled() {
    isSmsFilled.value = false;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    smsController.dispose();
    isPhoneFilled.dispose();
    isSmsFilled.dispose();
    super.dispose();
  }
}
