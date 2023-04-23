import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: mywidth * 0.004,
        right: mywidth * 0.04,
        // top: myheight * 0.005,
        bottom: myheight * 0.03
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: myheight * 0.05,
                child: Image.network(item.image)
              ),
            ),
            SizedBox(
              width: mywidth * 0.003,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.id,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '0.4 ' + item.symbol,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: myheight * 0.05,
                width: mywidth * 0.002,
                child: Sparkline(
                  data: item.sparklineIn7D.price,
                  lineWidth: 2.0,
                  lineColor: item.marketCapChangePercentage24H >=0
                  ? Colors.green
                  : Colors.red,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0,0.7],
                    colors: item.marketCapChangePercentage24H >=0
                    ? [Colors.green, Colors.green.shade100]
                    : [Colors.red, Colors.red.shade100]
                  ),
                ),
              ),
            ),
            SizedBox(
              width: mywidth * 0.02,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$' + item.currentPrice.toStringAsFixed(2) ,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item.priceChange24H.toString().contains('-')
                            ? "-\$" + item.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')
                            : '\$' + item.priceChange24H.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        width: mywidth * 0.03,
                      ),
                      Text(
                        item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: item.marketCapChangePercentage24H >=0
                              ? Colors.green
                              : Colors.red
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
