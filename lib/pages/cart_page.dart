import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../model/counter.dart';

class CartPage extends StatelessWidget {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Provide<Counter>(
              builder: (context, child, counter) {
                return Text('${counter.value}', style: Theme.of(context).textTheme.display1,);
              },
            ),
            RaisedButton(
              onPressed: () => Provide.value<Counter>(context).increment(),
              
              child: Text('Press'),
            ),
            Listener(
              onPointerDown: (e) async { 
                print('down...');
                isPressed = true;
                while (isPressed) {
                  Provide.value<Counter>(context).increment();
                  await Future.delayed(Duration(milliseconds: 200));
                }
               },
              onPointerUp: (e) { 
                print('up...');
                isPressed = false;
               },
              child: RaisedButton(child: Text('long press'), onPressed: (){}, ),
            )
          ],
        ),
      ),
    );
  }
}

