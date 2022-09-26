import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/themes/decorations.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';
import '../../constants.dart';

class GraphData {
  final int moneyPerDay;
  final int day;

  GraphData(this.moneyPerDay, this.day);
}

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> with GradientDecoration {
  List<Order> listOfCompletedOrders = [];
  // List<String> days
  List<int> days = [];
  List<GraphData> points = [];
  int currentGain = 0;

  fetchAllData() {
    // get all completed orders.
    for (var i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus! == false) {
        currentGain = currentGain + orderBox!.getAt(i)!.cost!;

        // add only days
        days.add(orderBox!.getAt(i)!.completedDate!.day);

        // add whole object
        listOfCompletedOrders.add(orderBox!.getAt(i)!);
      }
    }

    if (kDebugMode) {
      print(days);
    }
    // deleting duplicate values (days)
    days = days.toSet().toList();

    if (kDebugMode) {
      print("\n\n${days.length}");
    }
    int moneyPerDay = 0;
    int index = 0;
    for (int day in days) {
      // money count
      for (Order order in listOfCompletedOrders) {
        if (day == order.completedDate!.day) {
          moneyPerDay = moneyPerDay + order.cost!;
        }
      }

      // index++;

      points.add(GraphData(moneyPerDay, day));
      moneyPerDay *= 0;
    }
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: Text("MANAGE"),
        subtitle: Text("FINANCE"),
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        color: kScaffoldColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CurrentGain(currentGain: currentGain),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              width: double.infinity,
              height: 200,
              child: LineChart(
                swapAnimationCurve: Curves.bounceIn,
                swapAnimationDuration: const Duration(milliseconds: 250),
                LineChartData(
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        width: 3,
                        color: Colors.deepPurple[200]!,
                      ),
                      left: BorderSide(
                        width: 3,
                        color: Colors.deepPurple[200]!,
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                      axisNameWidget: const Text(
                        "Money Per Day",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                      axisNameWidget: const Text(
                        "Days",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  clipData: FlClipData.all(),
                  backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                  // backgroundColor: const Color.fromARGB(171, 203, 188, 214),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: const Color.fromARGB(255, 245, 245, 245),
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots
                            .map(
                              (e) => LineTooltipItem(
                                "",
                                const TextStyle(
                                  color: Colors.green,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${e.y.toString()}/Rs",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(139, 8, 102, 36),
                            Color.fromARGB(106, 96, 231, 137),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      color: Colors.green[700],
                      spots: points
                          .map((e) => FlSpot(
                                e.day.toDouble(),
                                e.moneyPerDay.toDouble(),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentGain extends StatelessWidget {
  final int currentGain;
  const CurrentGain({Key? key, required this.currentGain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color.fromRGBO(22, 60, 98, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CURRENT",
              style: TextStyle(
                color: Color.fromRGBO(215, 215, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${currentGain.toString()} PKR",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.arrow_upward,
                  color: Colors.lightGreenAccent,
                  size: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class LineCharts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const cutOffYValue = 0.0;
//     const yearTextStyle =
//     TextStyle(fontSize: 12, color: Colors.black);

//     return SizedBox(
//       width: 360,
//       height: 250,
//       child: LineChart(
//         LineChartData(
//           lineTouchData: LineTouchData(enabled: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 1),
//                 FlSpot(1, 1),
//                 FlSpot(2, 3),
//                 FlSpot(3, 4),
//                 FlSpot(3, 5),
//                 FlSpot(4, 4)
//               ],
//               isCurved: true,
//               barWidth: 2,
//               colors: [
//                 Colors.black,
//               ],
//               belowBarData: BarAreaData(
//                 show: true,
//                 colors: [Colors.lightBlue.withOpacity(0.5)],
//                 cutOffY: cutOffYValue,
//                 applyCutOffY: true,
//               ),
//               aboveBarData: BarAreaData(
//                 show: true,
//                 colors: [Colors.lightGreen.withOpacity(0.5)],
//                 cutOffY: cutOffYValue,
//                 applyCutOffY: true,
//               ),
//               dotData: FlDotData(
//                 show: false,
//               ),
//             ),
//           ],
//           minY: 0,
//           titlesData: FlTitlesData(
//             bottomTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 5,
//                 getTitles: (value) {
//                   switch (value.toInt()) {
//                     case 0:
//                       return '2017';
//                     case 1:
//                       return '2018';
//                     case 2:
//                       return '2019';
//                     case 3:
//                       return '2020';
//                     case 4:
//                       return '2021';
//                     default:
//                       return '';
//                   }
//                 }),
//             leftTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 return '\$ ${value + 150}';
//               },
//             ),
//           ),
//           axisTitleData: FlAxisTitleData(
//               leftTitle: AxisTitle(showTitle: true, titleText: 'Value', margin: 10),
//               bottomTitle: AxisTitle(
//                   showTitle: true,
//                   margin: 10,
//                   titleText: 'Year',
//                   textStyle: yearTextStyle,
//                   textAlign: TextAlign.right)),
//           gridData: FlGridData(
//             show: true,
//             checkToShowHorizontalLine: (double value) {
//               return value == 1 || value == 2 || value == 3 || value == 4;
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
