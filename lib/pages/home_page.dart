import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as prefix0;
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
              return Column(
                children: <Widget>[
                  SwiperDiy(list: data.map((item) => item['picture']['large']).toList(),)
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
    var res = await client.get('https://randomuser.me/api/?results=5&&gender=female');
    return res.data;
  }
}

class SwiperDiy extends StatelessWidget {
  final List list;

  SwiperDiy({Key key, this.list}): super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('pixel ratio: ${ScreenUtil.pixelRatio}');
    print('height: ${ScreenUtil.screenHeight}');
    print('width: ${ScreenUtil.screenWidth}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Image.network(list[index], fit: BoxFit.fill,);
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}

