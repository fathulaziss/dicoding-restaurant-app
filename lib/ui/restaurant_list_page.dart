import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_search_page.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  static const restaurantListTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              Provider.of<RestaurantProvider>(context, listen: false)
                  .getRestaurantSearch('');
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Recommendation restaurant for you!',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
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
            itemCount: restaurantProvider.restaurant.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant =
                  restaurantProvider.restaurant.restaurants[index];
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
