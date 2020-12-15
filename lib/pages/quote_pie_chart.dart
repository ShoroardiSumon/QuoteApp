import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quoteApp/model_classes/quote_model.dart';

class QuotePieChart extends StatefulWidget {
  final List<QuoteModel> quoteList;
  final Map authormap;
  QuotePieChart({this.quoteList, this.authormap});
  @override
  _QuotePieChartState createState() => _QuotePieChartState();
}

class _QuotePieChartState extends State<QuotePieChart> {
  // Map<String, double> dataMap = {
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };
  // List<Color> colorList = [
  //   Colors.red,
  //   Colors.green,
  //   Colors.blue,
  //   Colors.yellow,
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pie Chart'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                PieChart(
                  dataMap: widget.authormap,
                  animationDuration: Duration(milliseconds: 800),
                  //chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 1,
                  //colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  ringStrokeWidth: 32,
                  //centerText: "HYBRID",
                  legendOptions: LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    //legendShape: _BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
