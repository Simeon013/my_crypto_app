import 'package:flutter/material.dart';
import 'package:my_crypto_app/views/components/select_coin.dart';

class Item2 extends StatelessWidget {
  var item;
  Item2({this.item});

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mywidth * 0.03, vertical: myheight * 0.015),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => SelectCoin(select_item: item,)
            )
          );
        },
        child: Container(
          padding: EdgeInsets.only(
              left: mywidth * 0.03,
              right: mywidth * 0.06,
              top: myheight * 0.02,
              bottom: myheight * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: myheight * 0.035,
                child: Image.network(item.image),
              ),
              SizedBox(
                height: myheight * 0.02,
              ),
              Text(
                item.id,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: myheight * 0.001,
              ),
              Row(
                children: [
                  Text(
                    item.priceChange24H.toString().contains('-')
                        ? "-\$" +
                            item.priceChange24H
                                .toStringAsFixed(2)
                                .toString()
                                .replaceAll('-', '')
                        : '\$' + item.priceChange24H.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: mywidth * 0.03,
                  ),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: item.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
