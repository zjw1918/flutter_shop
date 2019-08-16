import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shop/configs/http_headers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var showTest = 'Welcome...';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            RaisedButton(
              onPressed: _goGet,
              child: Text('go get'),
            ),
            Text(showTest)
          ],),
        ),
      ),
    );
  }

  void _goGet() {
    fetch().then((v) {
      setState(() {
        showTest = v['data'].toString();
      });
    })
    .catchError((e) => print(e));
  }

  Future fetch() async {
    var client = Dio();
    client.options.headers = HTTP_HEADERS;
    var res = await client.get('https://time.geekbang.org/serv/v1/column/topList');
    return res.data;
  }
}