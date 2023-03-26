import 'package:flutter/material.dart';

class RestaurantDetailCardWidget extends StatelessWidget {
  const RestaurantDetailCardWidget({
    Key? key,
    required this.item,
    required this.margin,
  }) : super(key: key);

  final String item;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(item)),
    );
  }
}
