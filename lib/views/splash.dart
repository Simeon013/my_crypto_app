import 'package:flutter/material.dart';
import 'package:my_crypto_app/views/navbar.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: myheight,
            width: mywidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/1.gif'),
                Column(
                  children: [
                    Text(
                      'The Future',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Débutez efficacement avec la crypto',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mywidth*0.14),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFBC700),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: mywidth*0.05, vertical: myheight*0.013),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CREATE PORTFOLIO ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                              ),
                            ),
                            RotationTransition(
                              turns: AlwaysStoppedAnimation(310 / 360),
                              child: Icon(Icons.arrow_forward_rounded)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
