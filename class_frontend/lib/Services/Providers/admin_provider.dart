import 'package:class_frontend/Models/Admin/admin_model.dart';
import 'package:class_frontend/Services/Business%20Logic/admin_logic.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier{
  final AdminRepo _adminRepo;

  AdminProvider(this._adminRepo);

  Future<void> adminLogin(AdminDetails admin) async{
        try {
      await _adminRepo.adminLogin(admin);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}