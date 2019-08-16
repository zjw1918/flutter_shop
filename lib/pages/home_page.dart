import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
        body: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data['results'];
              return Column(
                children: <Widget>[
                  SwiperDiy(list: data,)
                ],
              );
            } else {
              return Container(
                child: Text('no data'),
              );
            }
          },
        ),
      ),
    );
  }

  // void _goGet() {
  //   fetch().then((v) {
  //     setState(() {
  //       showTest = v['data'].toString();
  //     });
  //   })
  //   .catchError((e) => print(e));
  // }

  Future fetch() async {
    var client = Dio();
    var res = await client.get('https://randomuser.me/api/?results=5&&gender=female');
    return res.data;
  }
}

class SwiperDiy extends StatelessWidget {
  final List list;

  SwiperDiy({Key key, this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Image.network(list[index]['picture']['large'], fit: BoxFit.fill,);
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}

