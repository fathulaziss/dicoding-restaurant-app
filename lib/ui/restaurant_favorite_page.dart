import 'package:dicoding_restaurant_app/data/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);

  static const restaurantFavoriteTitle = 'Favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Restaurant Favorite',
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
        return Consumer<DatabaseProvider>(
          builder: (context, databaseProvider, child) {
            if (databaseProvider.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (databaseProvider.state == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: databaseProvider.favorites.length,
                itemBuilder: (context, index) {
                  final restaurant = databaseProvider.favorites[index];
                  return RestaurantWidget(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RestaurantDetailPage.routeName,
                        arguments: restaurant,
                      );
                      restaurantProvider.getRestaurantDetail(restaurant.id);
                    },
                  );
                },
              );
            } else if (databaseProvider.state == ResultState.noData) {
              return Center(child: Text(databaseProvider.message));
            } else if (databaseProvider.state == ResultState.error) {
              return Center(child: Text(databaseProvider.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        );
      },
    );
  }
}
