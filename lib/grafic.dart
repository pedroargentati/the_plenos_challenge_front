import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Customer Satisfaction Score"),
        ),
        body: Center(
          child: CustomerSatisfactionChart(),
        ),
      ),
    );
  }
}

class CustomerSatisfactionChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // You can adjust this for your desired size
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: const Color(0xFFF2726F),
              value: 50, // Change this value to the desired value
              title: '0-50%',
            ),
            PieChartSectionData(
              color: const Color(0xFFFFC533),
              value: 25, // Change this value to the desired value
              title: '50-75%',
            ),
            PieChartSectionData(
              color: const Color(0xFF62B58F),
              value: 25, // Change this value to the desired value
              title: '75-100%',
            ),
          ],
          sectionsSpace: 0,
        ),
      ),
    );
  }
}
