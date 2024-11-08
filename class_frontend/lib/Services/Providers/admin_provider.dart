import 'package:class_frontend/Models/admin_model.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier{
  AdminData? _adminData;

  AdminData? get adminData => _adminData;

  void setAdmin(AdminData admin){
    _adminData= admin;
    notifyListeners();
  }

  void clearAdminData(){
    _adminData = null;
    notifyListeners();
  }
}