import 'package:flutter/material.dart';

bool validateAndSave(GlobalKey<FormState> key) {
  FormState? form = key.currentState;
  if (form?.validate() ?? false) {
    form?.save();
    return true;
  }
  return false;
}

String? validName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Vui long nhap ten';
  }
  return null;
}
