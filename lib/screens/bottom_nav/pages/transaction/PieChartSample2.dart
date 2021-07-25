import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/mathUtils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final List<List<String>> dataList;

  const PieChartSample2({Key? key, required this.dataList}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChart2State(dataList);
}

class PieChart2State extends State {
  double totalAmount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      totalAmount = calcAmount(0);
    });
  }

  double calcAmount(double amount) {
    dataList.forEach((element) {
      amount += double.parse(element[1]);
    });
    print(amount);
    return amount;
  }

  final List<List<String>> dataList;
  int touchedIndex = -1;

  PieChart2State(this.dataList);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int percentCalc(double catAmount) {
    return MathUtils.getPercentage(totalAmount, catAmount);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(dataList.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: DataRepositoryImpl().iconUrl(dataList[i][0])!.colorName,
        value: double.parse(dataList[i][1]),
        title: '', //${percentCalc(double.parse(dataList[i][1]))}%
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}
