import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              List data = snapshot.data['results'];
              print('fetch length: ${data.length}');
              return Column(
                children: <Widget>[
                  SwiperDiy(list: data.sublist(0, 5),),
                  TopNav(list: data.sublist(5, 15),)
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

  Future fetch() async {
    var client = Dio();
    var res = await client.get('https://randomuser.me/api/?results=15');
    return res.data;
  }
}

class SwiperDiy extends StatelessWidget {
  final List list;

  SwiperDiy({Key key, this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
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


class TopNav extends StatelessWidget {
  final List list;

  TopNav({Key key, this.list}): super(key: key);

  Widget _buildItem(BuildContext context, item) {
    return InkWell(
      onTap: () { print(item['name']['first']); },
      child: Column(children: <Widget>[
        ClipOval(child: Image.network(item['picture']['medium'], width: ScreenUtil().setWidth(95),),),
        Text(item['name']['first'])
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: list.map((item) => _buildItem(context, item)).toList(),
      ),
    );
  }
}
