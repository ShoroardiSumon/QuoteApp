import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.pie_chart,
        color: Colors.blue[900],
        size: 30,
      ),
    );
  }
}
