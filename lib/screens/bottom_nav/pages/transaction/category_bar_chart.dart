import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/utils/mathUtils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBarChart extends StatefulWidget {
  final List<TransactionModel> transactionList;
  final double totalExp;
  const CategoryBarChart(
      {Key? key, required this.transactionList, required this.totalExp})
      : super(key: key);

  @override
  _CategoryBarChartState createState() => _CategoryBarChartState();
}

class _CategoryBarChartState extends State<CategoryBarChart> {
  final controller = TransactionEntryController.to;
  List<List<double>> dataSet = [];
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("finding ${widget.totalExp}");
    Map<String, List<double>> dataList =
        controller.getDataListForCatBarchart(widget.transactionList);

    for (var i = 0; i < 12; i++) {
      dataSet.add([0]);
    }

    dataList.forEach((key, value) {
      if (dataSet.asMap().containsKey(int.parse(key))) {
        dataSet.removeAt(int.parse(key) - 1);
        dataSet.insert(int.parse(key) - 1, value);
      }
    });

    print(dataSet);
    // dataSet.forEach((element) {
    //   element.forEach((element) {
    //     print(element);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.catTransactionList.isNotEmpty)
        ? bodyBar(context, widget.totalExp)
        : Container());
  }

  AspectRatio bodyBar(BuildContext context, double totalAmount) {
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
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(
                        color: Color(
                          0xff939393,
                        ),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      );
                      Widget text;
                      switch (value.toInt()) {
                        case 0:
                          text = const Text('Jan', style: style);
                          break;
                        case 1:
                          text = const Text('Feb', style: style);
                          break;
                        case 2:
                          text = const Text('Mar', style: style);
                          break;
                        case 3:
                          text = const Text('Apr', style: style);
                          break;
                        case 4:
                          text = const Text('May', style: style);
                          break;
                        case 5:
                          text = const Text('Jun', style: style);
                          break;
                        case 6:
                          text = const Text('Jul', style: style);
                          break;
                        case 7:
                          text = const Text('Aug', style: style);
                          break;
                        case 8:
                          text = const Text('Sep', style: style);
                          break;
                        case 9:
                          text = const Text('Oct', style: style);
                          break;
                        case 10:
                          text = const Text('Nov', style: style);
                          break;
                        case 11:
                          text = const Text('Dec', style: style);
                          break;
                        default:
                          text = const Text('', style: style);
                          break;
                      }
                      return Padding(
                          padding: const EdgeInsets.only(top: 5), child: text);
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      interval: (MathUtils.gridSeparator(totalAmount) /
                              (((totalAmount.toInt().toString().length % 2 == 0)
                                  ? totalAmount.toInt().toString().length
                                  : totalAmount.toInt().toString().length + 1)))
                          .floorToDouble(),
                      showTitles: true,
                      reservedSize: 40),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 500 == 0,
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
                  toY: element[0],
                  rodStackItems: [
                    BarChartRodStackItem(0, 0, dark),
                    BarChartRodStackItem(0, 0, dark),
                    BarChartRodStackItem(element[0], 0, light),
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
