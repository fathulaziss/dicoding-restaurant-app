import 'package:flutter/material.dart';

class RestaurantDetailInfoWidget extends StatelessWidget {
  const RestaurantDetailInfoWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(title, style: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}
