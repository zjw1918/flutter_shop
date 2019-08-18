import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop/model/counter.dart';
import 'package:shop/pages/index_page.dart';

void main() {
  var counter = Counter();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
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
