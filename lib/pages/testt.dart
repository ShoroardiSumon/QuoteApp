import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quoteApp/database/database_helper.dart';
import 'package:quoteApp/model_classes/quote_database_model.dart';
import 'package:quoteApp/utility/app_sharedpreference.dart';

class PieChart extends StatefulWidget {
  final int id;
  PieChart({this.id});
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  AppSharedPreferences appSharedPreferences;

  List<QuoteDatabaseModel> quoteDatabaseModelList;
  List<QuoteDatabaseModel> quoteDatabaseModelFromJson(String str) =>
      List<QuoteDatabaseModel>.from(
          json.decode(str).map((x) => QuoteDatabaseModel.fromJson(x)));
  List<QuoteDB> allData = List();

  Future<List<QuoteDatabaseModel>> fetchFromDatabase() async {
    final String iD = await AppSharedPreferences.getSavedID();
    print(iD);
    print('gooooo');
    allData = await databaseHelper.getAllQuote();
    quoteDatabaseModelList = quoteDatabaseModelFromJson(allData[0].text);
    print('object 1');
    print(quoteDatabaseModelList.length);
    print('object 2');
    return quoteDatabaseModelList;
  }

  @override
  void initState() {
    super.initState();
    fetchFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: FutureBuilder(
            future: fetchFromDatabase(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: quoteDatabaseModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            quoteDatabaseModelList[index].data[index].author),
                      ),
                    );
                  },
                );
              } else
                return CircularProgressIndicator();
            },
          ),
        ));
  }
}
