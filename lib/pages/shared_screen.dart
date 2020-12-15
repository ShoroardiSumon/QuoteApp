import 'package:flutter/material.dart';

class SharedScreen extends StatefulWidget {
  final String theQuote;
  final String theAuthor;
  final String datetime;
  SharedScreen({this.theQuote, this.theAuthor, this.datetime});
  @override
  _SharedScreenState createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text('Shared Quote'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
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
                            widget.theQuote ?? 'No Quote',
                            style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "- " + widget.theAuthor ?? 'Author',
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
                          child: Center(
                              child: Text(
                            widget.datetime,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
