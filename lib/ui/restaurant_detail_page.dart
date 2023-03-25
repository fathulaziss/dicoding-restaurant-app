import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantModel restaurant;

  static const routeName = '/restaurant_detail';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: restaurant.id,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Restaurant Detail')),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, child) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRestaurantPicture(context, state.result.restaurant!),
                    _buildRestaurantInfo(context, state.result.restaurant!),
                  ],
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       _buildRestaurantPicture(context),
        //       _buildRestaurantInfo(context),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget _buildRestaurantPicture(
    BuildContext context,
    RestaurantModel restaurant,
  ) {
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
          image:
              NetworkImage('${ApiService().imageUrl}${restaurant.pictureId}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo(
    BuildContext context,
    RestaurantModel restaurant,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(
                restaurant.city,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star),
              Text(
                '${restaurant.rating}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            restaurant.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text('Foods', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          _buildFoods(restaurant),
          const SizedBox(height: 16),
          Text('Drinks', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          _buildDrinks(restaurant),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  SizedBox _buildDrinks(RestaurantModel restaurant) {
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

  SizedBox _buildFoods(RestaurantModel restaurant) {
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
