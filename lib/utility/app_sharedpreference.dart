import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<String> getSavedID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('saved_id');
  }

  static Future<void> setSavedID(String savedID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('saved_id', savedID);
  }
  //-----------------------------
  static Future<List> getQuoteModelList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('quote_model');
  }

  static Future<void> setQuoteModelList(List quotemodellist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('quote_model', quotemodellist);
  }
}
