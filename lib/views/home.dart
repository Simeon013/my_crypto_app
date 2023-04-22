import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_crypto_app/views/components/item.dart';
import 'package:my_crypto_app/views/components/item2.dart';

import '../models/coin_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: myheight,
        width: mywidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xfffcdb68),
              Color(0xffFBC700)
            ]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: myheight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: mywidth * 0.02 , vertical: myheight * 0.005),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      'Main Portfolio',
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ),
                  Text(
                    'Top 10 Coins',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  Text(
                    'Expérimental',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mywidth*0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 7,466.20 ',
                    style: TextStyle(
                        fontSize: 35
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(mywidth * 0.02),
                    height: myheight*0.05,
                    width: mywidth*0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Image.asset(
                      "assets/icons/5.1.png",
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mywidth*0.07),
              child: Row(
                children: [
                  Text(
                    '+162% all time',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: myheight * 0.002,
            ),
            Container(
              height: myheight * 0.7,
              width: mywidth,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade300,
                      spreadRadius: 3,
                      offset: Offset(0, 3))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: myheight * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mywidth * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Assets",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myheight * 0.02,
                  ),
                  isRefreshing == true
                      ? Center(
                        child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return Item(item: CoinMarket![index],);
                          }
                        ),
                  SizedBox(
                    height: myheight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mywidth * 0.05),
                    child: Row(
                      children: [
                        Text(
                          'Recommandé',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: myheight * 0.01,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: mywidth * 0.03),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CoinMarket!.length,
                        itemBuilder: (context, index){
                          return Item2(
                            item: CoinMarket![index],
                          );
                        }
                      ),
                    ),
                  ),
                  SizedBox(
                    height: myheight * 0.01,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRefreshing = true;

  List? CoinMarket = [];
  var CoinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json",
    });

    setState(() {
      isRefreshing = false;
    });

    if (response.statusCode == 200){
      var x = response.body;
      CoinMarketList = coinModelFromJson(x);
      setState(() {
        CoinMarket = CoinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }

}

