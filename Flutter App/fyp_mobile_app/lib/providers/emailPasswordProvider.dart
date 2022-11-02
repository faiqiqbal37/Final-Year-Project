import 'package:flutter/material.dart';

class Email with ChangeNotifier {
  String _email = "";
  String _phone = "";
  String _password = "";
  bool _emailOr = true;

  String _fullName = "";
  String _vehicleName = "";
  String _make = "";
  String _model = "";
  String _homeAddress = "";

  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  bool get emailOr => _emailOr;

  String get fullName => _fullName;
  String get vehicleName => _vehicleName;
  String get make => _make;
  String get model => _model;
  String get homeAdress => _homeAddress;

  // Email(String email, String password) {
  //   _email = email;
  //   _password = password;
  // }

  void setEmail(String em) {
    _email = em;
    notifyListeners();
  }

  void setPhone(String ph) {
    _phone = ph;
    notifyListeners();
  }

  void setFullName(String name) {
    _fullName = name;
    notifyListeners();
  }

  void setVehicleName(String name) {
    _vehicleName = name;
    notifyListeners();
  }

  void setMake(String name) {
    _make = name;
    notifyListeners();
  }

  void setModel(String model) {
    _model = model;
    notifyListeners();
  }

  void setAddress(String address) {
    _homeAddress = address;
    notifyListeners();
  }

  void setPassword(String pass) {
    _password = pass;
    notifyListeners();
  }

  void setEmailOrPhoneStatus(bool set) {
    _emailOr = set;
    notifyListeners();
  }
}
