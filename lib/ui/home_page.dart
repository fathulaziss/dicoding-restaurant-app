import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/ui/setting_page.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const RestaurantFavoritePage(),
    const SettingPage(),
  ];

  final _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: RestaurantListPage.restaurantListTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: RestaurantFavoritePage.restaurantFavoriteTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingPage.settingTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _bottomNavIndex,
      items: _bottomNavBarItems,
      onTap: _onBottomNavTapped,
    );
  }
}
