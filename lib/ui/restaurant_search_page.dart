import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/custom_search_widget.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_search';

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final controllerSearch = TextEditingController();

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Search')),
      body: Column(
        children: [
          Consumer<RestaurantProvider>(
            builder: (context, restaurantProvider, child) {
              return CustomSearchWidget(
                controller: controllerSearch,
                onSubmitted: (value) {
                  restaurantProvider.getRestaurantSearch(value);
                },
              );
            },
          ),
          Expanded(child: _buildRestaurantList(context)),
        ],
      ),
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        if (restaurantProvider.state == ResultState.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (restaurantProvider.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: restaurantProvider.restaurantSearch.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant =
                  restaurantProvider.restaurantSearch.restaurants[index];
              return RestaurantWidget(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RestaurantDetailPage.routeName,
                    arguments: restaurant,
                  );
                },
              );
            },
          );
        } else if (restaurantProvider.state == ResultState.noData) {
          return Center(child: Text(restaurantProvider.message));
        } else if (restaurantProvider.state == ResultState.error) {
          return Center(child: Text(restaurantProvider.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
