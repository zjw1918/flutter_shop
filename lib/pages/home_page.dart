import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  TopNav(list: data.sublist(5, 15),),
                  AdBanner(url: 'images/adbanner.jpg',),
                  DianZhangPhone(phone: data[0]['phone'],)
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
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ClipOval(child: Image.network(item['picture']['medium'], width: ScreenUtil().setWidth(95),),),
          ),
          Expanded(
            flex: 1,
            child: Text(item['name']['first'],),
          )
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: list.map((item) => _buildItem(context, item)).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String url;

  AdBanner({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(url),
    );
  }
}

class DianZhangPhone extends StatelessWidget {
  final phone;

  DianZhangPhone({this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () { _launchUrl(context); },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: ScreenUtil().setHeight(200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Text('店长电话: '),
                Text(phone)
              ],
            ),
        ),
      ),
    );
  }

  void _launchUrl(BuildContext context) async {
    // String url = 'tel:' + phone;
    String url = 'https://baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('无法拨打');
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('无法打开url')));
    }
  }
}