import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = '';
  bool isLoading = true;

  callApi() async {
    var response =
        await http.get(Uri.parse('https://meme-api.herokuapp.com/gimme'));

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      url = jsonResponse['url'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meme Share 2.0',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            color: Colors.purple,
            // child: Image.asset(
            //   'images/mypic.jpg',
            //   // height: MediaQuery.of(context).size.height,
            //   // width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.topCenter,
            // ),
          ),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 450,
                  width: 450,
                  padding: EdgeInsets.all(10),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Image.network(
                          url,
                          height: 450,
                          width: 450,
                        )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Padding(padding: EdgeInsets.all(10)),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width - 250,
                    color: HexColor('#7d066b'),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        callApi();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#7d066b'),
                      ),
                      child: Text(
                        'NEXT MEME',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 370,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width - 250,
                    color: HexColor('#7d066b'),
                    child: ElevatedButton(
                      onPressed: () {
                        Share.share('Hey! Checkout this awesome meme ' + url);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#7d066b'),
                      ),
                      child: Text(
                        'SHARE MEME',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
