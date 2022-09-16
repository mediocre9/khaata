import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:khata/models/model/order.dart';
import 'package:khata/widgets/custom_app_bar.dart';
import 'package:khata/widgets/custom_drawer.dart';
import '../../constants.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<Order> orders = [];
  int currentGain = 0;

  fetchAllData() {
    for (var i = 0; i < orderBox!.values.length; i++) {
      if (orderBox!.getAt(i)!.pendingStatus! == false) {
        currentGain = currentGain + orderBox!.getAt(i)!.cost!;
        orders.add(orderBox!.getAt(i)!);
      }
    }
  }

  @override
  void initState() {
    fetchAllData();
    super.initState();
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: Text("MANAGE"),
        subtitle: Text("FINANCE"),
      ),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: Container(
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
                        CurrentGain(
                          currentGain: currentGain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text("Finance Graph Area"),
                    const SizedBox(height: 40),
                    AspectRatio(
                      aspectRatio: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 300,
                        child: LineChart(
                          swapAnimationCurve: Curves.bounceIn,
                          swapAnimationDuration: const Duration(milliseconds: 250),
                          LineChartData(
                            backgroundColor:
                                const Color.fromARGB(255, 236, 236, 236),
                            borderData: FlBorderData(show: true),
                            gridData: FlGridData(
                              show: false,
                              horizontalInterval: 1.6,
                              drawVerticalLine: false,
                            ),
                            titlesData: FlTitlesData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                color: Colors.purple,
                                isCurved: true,
                                spots: orders
                                    .map(
                                      (e) => FlSpot(
                                        (15 * i++).toDouble(),
                                        e.cost!.toDouble(),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Jan';
              break;
            case 3:
              text = 'Mar';
              break;
            case 5:
              text = 'May';
              break;
            case 7:
              text = 'Jul';
              break;
            case 9:
              text = 'Sep';
              break;
            case 11:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );
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

// class LineChartSample5 extends StatelessWidget {
//   final List<int> showIndexes = const [1, 3, 5];
//   final List<FlSpot> allSpots = const [
//     FlSpot(0, 1),
//     FlSpot(1, 2),
//     FlSpot(2, 1.5),
//     FlSpot(3, 3),
//     FlSpot(4, 3.5),
//     FlSpot(5, 5),
//     FlSpot(6, 8),
//   ];

//   const LineChartSample5({Key? key}) : super(key: key);

// Widget bottomTitleWidgets(double value, TitleMeta meta) {
//   const style = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.blueGrey,
//     fontFamily: 'Digital',
//     fontSize: 18,
//   );
//   String text;
//   switch (value.toInt()) {
//     case 0:
//       text = '00:00';
//       break;
//     case 1:
//       text = '04:00';
//       break;
//     case 2:
//       text = '08:00';
//       break;
//     case 3:
//       text = '12:00';
//       break;
//     case 4:
//       text = '16:00';
//       break;
//     case 5:
//       text = '20:00';
//       break;
//     case 6:
//       text = '23:59';
//       break;
//     default:
//       return Container();
//   }

//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: Text(text, style: style),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     final lineBarsData = [
//       LineChartBarData(
//         showingIndicators: showIndexes,
//         spots: allSpots,
//         isCurved: true,
//         barWidth: 4,
//         shadow: const Shadow(
//           blurRadius: 8,
//           color: Colors.black,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors: [
//               const Color(0xff12c2e9).withOpacity(0.4),
//               const Color(0xffc471ed).withOpacity(0.4),
//               const Color(0xfff64f59).withOpacity(0.4),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         dotData: FlDotData(show: false),
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xff12c2e9),
//             Color(0xffc471ed),
//             Color(0xfff64f59),
//           ],
//           stops: [0.1, 0.4, 0.9],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//     ];

//     final tooltipsOnBar = lineBarsData[0];

//     return SizedBox(
//       width: 300,
//       height: 140,
//       child: LineChart(
//         LineChartData(
//           showingTooltipIndicators: showIndexes.map((index) {
//             return ShowingTooltipIndicators([
//               LineBarSpot(tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar),
//                   tooltipsOnBar.spots[index]),
//             ]);
//           }).toList(),
//           lineTouchData: LineTouchData(
//             enabled: false,
//             getTouchedSpotIndicator:
//                 (LineChartBarData barData, List<int> spotIndexes) {
//               return spotIndexes.map((index) {
//                 return TouchedSpotIndicatorData(
//                   FlLine(
//                     color: Colors.pink,
//                   ),
//                   FlDotData(
//                     show: true,
//                     getDotPainter: (spot, percent, barData, index) =>
//                         FlDotCirclePainter(
//                       radius: 8,
//                       color: lerpGradient(
//                         barData.gradient!.colors,
//                         barData.gradient!.stops!,
//                         percent / 100,
//                       ),
//                       strokeWidth: 2,
//                       strokeColor: Colors.black,
//                     ),
//                   ),
//                 );
//               }).toList();
//             },
//             touchTooltipData: LineTouchTooltipData(
//               tooltipBgColor: Colors.pink,
//               tooltipRoundedRadius: 8,
//               getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                 return lineBarsSpot.map((lineBarSpot) {
//                   return LineTooltipItem(
//                     lineBarSpot.y.toString(),
//                     const TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   );
//                 }).toList();
//               },
//             ),
//           ),
//           lineBarsData: lineBarsData,
//           minY: 0,
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               axisNameWidget: const Text('count'),
//               sideTitles: SideTitles(
//                 showTitles: false,
//                 reservedSize: 0,
//               ),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 interval: 1,
//                 // getTitlesWidget: bottomTitleWidgets,
//               ),
//             ),
//             rightTitles: AxisTitles(
//               axisNameWidget: const Text('count'),
//               sideTitles: SideTitles(
//                 showTitles: false,
//                 reservedSize: 0,
//               ),
//             ),
//             topTitles: AxisTitles(
//               axisNameWidget: const Text(
//                 'Wall clock',
//                 textAlign: TextAlign.left,
//               ),
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 0,
//               ),
//             ),
//           ),
//           gridData: FlGridData(show: false),
//           borderData: FlBorderData(
//             show: true,
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Lerps between a [LinearGradient] colors, based on [t]
// Color lerpGradient(List<Color> colors, List<double> stops, double t) {
//   if (colors.isEmpty) {
//     throw ArgumentError('"colors" is empty.');
//   } else if (colors.length == 1) {
//     return colors[0];
//   }

//   if (stops.length != colors.length) {
//     stops = [];

//     /// provided gradientColorStops is invalid and we calculate it here
//     colors.asMap().forEach((index, color) {
//       final percent = 1.0 / (colors.length - 1);
//       stops.add(percent * index);
//     });
//   }

//   for (var s = 0; s < stops.length - 1; s++) {
//     final leftStop = stops[s], rightStop = stops[s + 1];
//     final leftColor = colors[s], rightColor = colors[s + 1];
//     if (t <= leftStop) {
//       return leftColor;
//     } else if (t < rightStop) {
//       final sectionT = (t - leftStop) / (rightStop - leftStop);
//       return Color.lerp(leftColor, rightColor, sectionT)!;
//     }
//   }
//   return colors.last;
// }
