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

  static Future<List> getSharedQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('shared_quote');
  }

  static Future<void> setSharedQuote(List sharedquotelist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('shared_quote', sharedquotelist);
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
