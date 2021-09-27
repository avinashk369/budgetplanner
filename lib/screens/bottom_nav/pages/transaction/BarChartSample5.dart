import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/utils/mathUtils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample5 extends StatefulWidget {
  final List<TransactionModel> dataList;
  final double totalAmount;
  const BarChartSample5(
      {Key? key, required this.dataList, required this.totalAmount})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  final controller = TransactionEntryController.to;
  late List<List<double>> dataSet;
  double interval = 5000;
  @override
  void initState() {
    // TODO: implement initState

    var val = (MathUtils.gridSeparator(widget.totalAmount) /
            ((widget.totalAmount.toString().length % 2 == 0)
                ? widget.totalAmount.toString().length
                : widget.totalAmount.toString().length + 1))
        .roundToDouble();
    //print("divider ${(val / 1000).round()}");
    interval = ((val / 1000).round() * 1000);
    //print("$interval Avinash ${widget.totalAmount}");
    super.initState();
  }

  void setBarData() {
    dataSet = [];
    Map<String, List<double>> dataList =
        controller.getDataListForBarchart(widget.dataList);

    for (var i = 0; i < 12; i++) {
      dataSet.add([0, 0, 0]);
    }

    dataList.forEach((key, value) {
      if (dataSet.asMap().containsKey(int.parse(key))) {
        dataSet.removeAt(int.parse(key) - 1);
        dataSet.insert(int.parse(key) - 1, value);
      }
    });
  }

  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    setBarData();
    return AspectRatio(
      aspectRatio: 1.66,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Theme.of(context).primaryColor,
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
                  // getTextStyles: (value) =>
                  //     const TextStyle(color: Color(0xff939393), fontSize: 10),
                  getTextStyles: (context, value) =>
                      const TextStyle(color: Color(0xff939393), fontSize: 10),
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
                  interval: interval > 0 ? interval : 5000,
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(
                        0xff939393,
                      ),
                      fontSize: 10),
                  margin: 0,
                ),
                topTitles: SideTitles(
                  showTitles: false,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(
                        0xff939393,
                      ),
                      fontSize: 10),
                  margin: 0,
                ),
                rightTitles: SideTitles(
                  showTitles: false,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(
                        0xff939393,
                      ),
                      fontSize: 10),
                  margin: 0,
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 5000 == 0,
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
    );
  }

  List<BarChartGroupData> getData() {
    List<BarChartGroupData> brData = [];
    int i = 0;
    dataSet.forEach(
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
                    BarChartRodStackItem(0, 0, dark),
                    BarChartRodStackItem(0, element[1], dark),
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
