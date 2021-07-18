import 'dart:math';

import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        height: 300,
        child: AspectRatio(
          aspectRatio: 1.66,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(0xff939393), fontSize: 10),
                      margin: 10,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Jan';
                          case 1:
                            return 'Feb';
                          case 2:
                            return 'Mar';
                          case 3:
                            return 'Apr';
                          case 4:
                            return 'May';
                          case 5:
                            return 'Jun';
                          case 6:
                            return 'Jul';
                          case 7:
                            return 'Aug';
                          case 8:
                            return 'Sep';
                          case 9:
                            return 'Oct';
                          case 10:
                            return 'Nov';
                          case 11:
                            return 'Dec';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      interval: 1000,
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(
                            0xff939393,
                          ),
                          fontSize: 10),
                      margin: 0,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 1000 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xffe7e8ec),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: 4,
                  barGroups: getData(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    List<List<double>> dataList = [
      [1000, 800, 200], //jan
      [1200, 1100, 100], //feb
      [500, 450, 50], //mar
      [1000, 30, 70], //apr
      [1500, 800, 700], //may
      [180, 80, 100], //jun
      [1200, 800, 400], //jul
      [1700, 700, 1000], //aug
      [1000, 890, 10], //sep
      [2000, 800, 1200], //oct
      [2800, 2400, 200], //nov
      [1000, 700, 300], //dec
    ];

    List<BarChartGroupData> brData = [];
    int i = 0;
    dataList.forEach(
      (element) {
        brData.add(
          BarChartGroupData(
            x: i,
            barsSpace: 1,
            barRods: [
              BarChartRodData(
                  width: 20,
                  y: element[0],
                  rodStackItems: [
                    BarChartRodStackItem(0, element[2], dark),
                    BarChartRodStackItem(element[2], element[1], normal),
                    BarChartRodStackItem(element[1], element[0], light),
                  ],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10))),
            ],
          ),
        );
        i++;
      },
    );
    return brData;
  }
}
