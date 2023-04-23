import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class SelectCoin extends StatefulWidget {
  var select_item;

  SelectCoin({this.select_item});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    getChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: myheight,
        width: mywidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mywidth * 0.05, vertical: myheight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: myheight * 0.08,
                        child: Image.network(widget.select_item.image),
                      ),
                      SizedBox(
                        width: mywidth * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.select_item.id,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: myheight * 0.01,
                          ),
                          Text(
                            widget.select_item.symbol,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.select_item.currentPrice}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: myheight * 0.01,
                      ),
                      Text(
                        '${widget.select_item.marketCapChangePercentage24H}%',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: widget.select_item
                                        .marketCapChangePercentage24H >=
                                    0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mywidth * 0.05, vertical: myheight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Low',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: myheight * 0.01,
                          ),
                          Text(
                            '\$${widget.select_item.low24H}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'High',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: myheight * 0.01,
                          ),
                          Text(
                            '\$${widget.select_item.high24H}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Vol',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: myheight * 0.01,
                          ),
                          Text(
                            '\$${widget.select_item.totalVolume}M',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: myheight * 0.015,
                ),
                Container(
                  height: myheight * 0.4,
                  width: mywidth,
                  // color: Colors.amber,
                  child: isRefreshing == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xffFBC700),
                          ),
                        )
                      : itemChart == null
                          ? Padding(
                              padding: EdgeInsets.all(myheight * 0.06),
                              child: Center(
                                child: Text(
                                  'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : SfCartesianChart(
                              trackballBehavior: trackballBehavior,
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePanning: true,
                                enableDoubleTapZooming: true,
                                zoomMode: ZoomMode.x,
                              ),
                              series: <CandleSeries>[
                                CandleSeries<ChartModel, int>(
                                    enableSolidCandles: true,
                                    enableTooltip: true,
                                    bullColor: Colors.green,
                                    bearColor: Colors.red,
                                    dataSource: itemChart!,
                                    xValueMapper: (ChartModel sales, _) =>
                                        sales.time,
                                    lowValueMapper: (ChartModel sales, _) =>
                                        sales.low,
                                    highValueMapper: (ChartModel sales, _) =>
                                        sales.high,
                                    openValueMapper: (ChartModel sales, _) =>
                                        sales.open,
                                    closeValueMapper: (ChartModel sales, _) =>
                                        sales.close,
                                    animationDuration: 55),
                              ],
                            ),
                ),
                SizedBox(
                  height: myheight * 0.01,
                ),
                Center(
                  child: Container(
                    height: myheight * 0.03,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: text.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mywidth * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  text_bool = [
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                  text_bool[index] = true;
                                });
                                setDays(text[index]);
                                getChart();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mywidth * 0.03,
                                    vertical: myheight * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: text_bool[index] == true
                                      ? Color(0xffFBC700).withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  text[index],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: myheight * 0.02,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: mywidth * 0.06),
                      child: Text(
                        'News',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mywidth * 0.06,
                          vertical: myheight * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nobis sunt tempore at voluptas sequi odio fugiat, reprehenderit quisquam, voluptatibus cupiditate ab omnis ducimus iste itaque quis nihil? Minima, iusto omnis.',
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          Container(
                            width: mywidth * 0.2,
                            child: CircleAvatar(
                              radius: myheight * 0.03,
                              backgroundImage:
                                  AssetImage('assets/images/11.PNG'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            )),
            Container(
              height: myheight * 0.1,
              width: mywidth,
              // color: Colors.amber,
              child: Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: myheight * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: mywidth * 0.05,
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mywidth * 0.05,
                              vertical: myheight * 0.01),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffFBC700)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: myheight * 0.02,
                              ),
                              Text(
                                'Ajouter au portfolio',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mywidth * 0.05,
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: mywidth * 0.05,
                                vertical: myheight * 0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.5)),
                            child: Image.asset(
                              'assets/icons/3.1.png',
                              height: myheight * 0.03,
                              color: Colors.black,
                            ),
                          )),
                      SizedBox(
                        width: mywidth * 0.05,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> text_bool = [false, false, true, false, false, false];

  int days = 30;
  setDays(String txt) {
    switch (txt) {
      case 'D':
        setState(() {
          days = 1;
        });
        break;
      case 'W':
        setState(() {
          days = 7;
        });
        break;
      case 'M':
        setState(() {
          days = 30;
        });
        break;
      case '3M':
        setState(() {
          days = 90;
        });
        break;
      case '6M':
        setState(() {
          days = 180;
        });
        break;
      case 'Y':
        setState(() {
          days = 365;
        });
        break;
      default:
    }
  }

  List<ChartModel>? itemChart;

  bool isRefreshing = true;

  Future<void> getChart() async {
    String url =
        '${'https://api.coingecko.com/api/v3/coins/' + widget.select_item.id}/ohlc?vs_currency=usd&days=$days';

    setState(() {
      isRefreshing = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    setState(() {
      isRefreshing = false;
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> model_list =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = model_list;
      });
    } else {
      print(response.statusCode);
    }
  }
}
