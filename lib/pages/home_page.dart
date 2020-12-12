import 'package:flutter/material.dart';
import 'package:quoteApp/database/database_helper.dart';
import 'package:quoteApp/model_classes/quote_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:quoteApp/pages/quote_tabs.dart';
import 'package:quoteApp/utility/app_sharedpreference.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProgressDialog _progressDialog;
  List<String> sharedQuoteList =[];
  AppSharedPreferences appSharedPreferences;
  QuoteDB quoteDB;
  DatabaseHelper helper;
  List<QuoteModel> _quoteModelList;
  List<QuoteModel> quoteModelFromJson(String str) => List<QuoteModel>.from(
      json.decode(str).map((x) => QuoteModel.fromJson(x)));

  Future<String> fetchQuote() async {
    final response = await http.get('https://type.fit/api/quotes');
    _quoteModelList = quoteModelFromJson(response.body.toString());
    print(_quoteModelList.length);
    //await AppSharedPreferences.setQuoteModelList(_quoteModelList);

    // for (int i = 0; i < _quoteModelList.length; i++) {
    //   QuoteDB quoteDB = QuoteDB();
    //   print(_quoteModelList[i].author ?? 'Author');
    //   quoteDB.author = _quoteModelList[i].author ?? 'No Author';
    //   quoteDB.text = _quoteModelList[i].text ?? 'No Quote';
    //   print(quoteDB);
    //   DatabaseHelper helper = DatabaseHelper.instance;
    //   int id = await helper.insertQuote(quoteDB);
    //   print('DB ID = $id');
    // }
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.fetchQuote();
  }

  String dateTime;

  int i = 0;
  _randomQuote() {
    Random random = Random();
    var ran = random.nextInt(_quoteModelList.length - 1) + 0;
    print("Random number: $ran");
    setState(() {
      i = ran;
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          title: Text("QuoteApp"),
          centerTitle: true,
          leading: Text(''),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: fetchQuote(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.indigo[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 2, color: Colors.indigo),
                        ),
                        child: Text(
                          'QUOTE OF THE DAY',
                          style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  _quoteModelList[i].text ?? 'No Quote',
                                  style: TextStyle(
                                      color: Colors.indigo[900],
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                height: 50,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "- " + _quoteModelList[i].author ?? 'Author',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 1,
                                color: Colors.indigo[300],
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        height: 60,
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              onChanged: (date) {
                                            print('change $date in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                            setState(() {
                                              dateTime = date.toString();
                                            });
                                          }, currentTime: DateTime.now());
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "Select Date & Time",
                                          style: TextStyle(
                                              color: Colors.indigo[900],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    dateTime == null
                                        ? Container()
                                        : Container(
                                            width: 1,
                                            color: Colors.indigo[300],
                                          ),
                                    dateTime == null
                                        ? Container()
                                        : Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 2),
                                              alignment: Alignment.center,
                                              height: 60,
                                              color: Colors.white,
                                              child: Text(
                                                dateTime ?? '',
                                                style: TextStyle(
                                                    color: Colors.indigo[900],
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                          elevation: 0,
                          color: Colors.blue[900],
                          height: 60,
                          minWidth: 500,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'SHARE',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          onPressed: () async {
                            await _progressDialog.show();
                            sharedQuoteList.add(i.toString());
                            await AppSharedPreferences.setSharedQuote(
                                sharedQuoteList);
                            await _progressDialog.hide();
                            Navigator.of(context).push(
                                _createRoute(QuoteTabs(), Offset(1, 0), 600));
                          }),
                    ],
                  ),
                );
              }
              return Container(
                height: 700,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        // body: Container(
        //   child: FutureBuilder(
        //     future: fetchQuote(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData) {
        //         return ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: _quoteModelList.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Card(
        //               child: ListTile(
        //                 title:
        //                     Text(_quoteModelList[index].author ?? 'Author'),
        //                 subtitle:
        //                     Text(_quoteModelList[index].text ?? 'Quote'),
        //               ),
        //             );
        //           },
        //         );
        //       }
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     },
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.refresh,
              size: 40,
            ),
            elevation: 0,
            onPressed: () {
              _randomQuote();
              setState(() {
                dateTime = null;
              });
              // print('delete all data');
              // DatabaseHelper helper = DatabaseHelper.instance;
              //helper.deleteAll();
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => TestDataBase()));
              // print('go to page');
            }),
      ),
    );
  }

  Route _createRoute(Widget _page, Offset _offset, int _duration) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      pageBuilder: (context, animation, secondaryAnimation) => _page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: _offset, end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: _duration),
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
