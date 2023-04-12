import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/data/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({required this.restaurant, Key? key})
      : super(key: key);

  final RestaurantModel restaurant;

  static const routeName = '/restaurant_detail';

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, databaseProvider, child) {
        return FutureBuilder(
          future: databaseProvider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Restaurant Detail'),
                actions: [
                  if (isFavorite)
                    IconButton(
                      onPressed: () {
                        databaseProvider.removeFavorite(restaurant.id);
                      },
                      icon: const Icon(Icons.favorite),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        databaseProvider.addFavorite(restaurant);
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                ],
              ),
              body: _buildBody(context),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (context) =>
          RestaurantDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, restaurantDetailProvider, child) {
          if (restaurantDetailProvider.state == ResultState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (restaurantDetailProvider.state == ResultState.hasData) {
            return RestaurantDetailWidget(
              restaurant: restaurantDetailProvider.restaurantDetail.restaurant!,
            );
          } else if (restaurantDetailProvider.state == ResultState.noData) {
            return Center(child: Text(restaurantDetailProvider.message));
          } else if (restaurantDetailProvider.state == ResultState.error) {
            return Center(child: Text(restaurantDetailProvider.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
