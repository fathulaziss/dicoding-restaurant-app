import 'package:dicoding_restaurant_app/ui/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.pushReplacementNamed(context, HomePage.routeName),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'RESTAURANT APP',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
