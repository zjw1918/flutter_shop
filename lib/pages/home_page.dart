import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = 'Welcome';
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Home'),),
        body: SingleChildScrollView(child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: editingController,
                decoration: InputDecoration(
                  labelText: '美女类型',
                  prefixIcon: Icon(Icons.account_box, size: 28.0,),
                  helperText: '请输入喜欢的类型',
                  contentPadding: EdgeInsets.all(10.0),
                  suffixIcon: IconButton(icon: Icon(Icons.close), onPressed: () => editingController.clear(),)
                ),
                autofocus: false, // 防止键盘自动弹出
              ),
              RaisedButton(
                onPressed: _chooseAction,
                child: Text('choosed done.'),
              ),
              Text(showText, overflow: TextOverflow.ellipsis, maxLines: 1,)
            ],
          ),
        ),)

      ),
    );
  }

  void _chooseAction() {
    print('check chosed info...');
    if (editingController.text.toString() == '') {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(title: Text('不能为空'),)
      );
    } else {
      getHttp(editingController.text.toString())
      .then((v) {
        setState(() {
          showText = v['data']['name'];
        });
      })
      .catchError((e) {
        print(e);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('net error'),));
      });
    }
  }

  Future getHttp(String input) async {
    final data = {'name': input};
    var res = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian', 
      queryParameters: data,
    );
    return res.data;
  }
}