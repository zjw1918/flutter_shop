import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/category_page.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List pages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = pages[currentIndex];
    super.initState();
  }

  void onTap(index) {
    setState(() {
      currentIndex = index;
      currentPage = pages[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
      ),
      body: currentPage,
    );
  }
}