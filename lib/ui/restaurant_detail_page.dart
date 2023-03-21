import 'package:dicoding_restaurant_app/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantModel restaurant;

  static const routeName = '/restaurant_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Detail')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRestaurantPicture(context),
            _buildRestaurantInfo(context),
          ],
        ),
      ),
    );
  }

  Container _buildRestaurantPicture(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        image: DecorationImage(
          image: NetworkImage(restaurant.pictureId),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 4),
          Text(
            restaurant.city,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: 4),
          Text(
            restaurant.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text('Foods', style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: 4),
          _buildFoods(),
          const SizedBox(height: 16),
          Text('Drinks', style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(height: 4),
          _buildDrinks(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  SizedBox _buildDrinks() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: restaurant.menus.drinks.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(restaurant.menus.drinks[index].name)),
          );
        },
      ),
    );
  }

  SizedBox _buildFoods() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: restaurant.menus.foods.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(restaurant.menus.foods[index].name)),
          );
        },
      ),
    );
  }
}
