import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String _language = 'mar';

  String get language => _language;
  
  void toggleLanguage(){
    _language = _language =='mar' ? 'eng' : 'mar' ; 
    notifyListeners(); 
  }

  void setLanguage(String lang){
    _language = lang;
    notifyListeners();
  }
}

