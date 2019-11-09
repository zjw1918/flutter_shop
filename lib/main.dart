import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/counter.dart';
import 'package:shop/pages/index_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: MyApp(),
      builder: (context) => Counter(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '京东',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
