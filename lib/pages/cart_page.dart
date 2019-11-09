import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text('${counter.value}', style: Theme.of(context).textTheme.display1,);
              },
            ),
            RaisedButton(
              onPressed: () => Provider.of<Counter>(context).increment(),
              
              child: Text('Press'),
            ),
            Listener(
              onPointerDown: (e) async { 
                print('down...');
                isPressed = true;
                while (isPressed) {
                  Provider.of<Counter>(context).increment();
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

