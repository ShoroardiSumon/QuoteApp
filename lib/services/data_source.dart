import 'package:flutter/material.dart';
import 'package:quoteApp/database/database_helper.dart';

class TestDataBase extends StatefulWidget {
  @override
  _TestDataBaseState createState() => _TestDataBaseState();
}

class _TestDataBaseState extends State<TestDataBase> {
  final DatabaseHelper databasehelper = DatabaseHelper.instance;
  List<QuoteDB> quotedblist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: FutureBuilder(
          future: databasehelper.getAllQuote(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: quotedblist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(quotedblist[index].author ?? 'No Author'),
                        subtitle: Text(quotedblist[index].text ?? 'No Quote'),
                      ),
                    );
                  },
                );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}