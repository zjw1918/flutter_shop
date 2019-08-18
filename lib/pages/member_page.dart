import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop/model/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Provide<Counter>(
          builder: (content, child, counter) => Text('${counter.value}'),
        ),
      ),
    );
  }
}