import 'package:flutter/material.dart';

class QuoteTabs extends StatefulWidget {
  @override
  _QuoteTabsState createState() => _QuoteTabsState();
}

class _QuoteTabsState extends State<QuoteTabs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Tabs Here",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
