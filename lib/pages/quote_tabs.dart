import 'package:flutter/material.dart';
import 'package:quoteApp/model_classes/quote_model.dart';
import 'package:quoteApp/utility/app_sharedpreference.dart';

class QuoteTabs extends StatefulWidget {
  @override
  _QuoteTabsState createState() => _QuoteTabsState();
}

class _QuoteTabsState extends State<QuoteTabs> {

  @override
  void initState() {
    super.initState();
    this.fetchSharedPreferenceValue();
  }

  List<String> sharedPreferencesQuote;
  List<QuoteModel> quoteModelList;
  Future<Null> fetchSharedPreferenceValue()async{
    sharedPreferencesQuote = await AppSharedPreferences.getSharedQuote();
    //quoteModelList = await AppSharedPreferences.getQuoteModelList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quote"),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: <Widget>[
            ]
          ), 
          preferredSize: Size.fromHeight(50.0),
        ),
      ),
      body: TabBarView(
        children: [

        ]
      ),
    );
  }
}
