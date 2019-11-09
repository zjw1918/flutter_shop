import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Counter>(
          builder: (content, counter, child) => Text('${counter.value}'),
        ),
      ),
    );
  }
}