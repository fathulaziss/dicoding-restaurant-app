import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/data/provider/database_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
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
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProvider, child) {
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
                  body: restaurantProvider.state == ResultState.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : restaurantProvider.state == ResultState.hasData
                          ? RestaurantDetailWidget(
                              restaurant: restaurantProvider
                                  .restaurantDetail.restaurant!,
                            )
                          : restaurantProvider.state == ResultState.noData
                              ? Center(child: Text(restaurantProvider.message))
                              : restaurantProvider.state == ResultState.error
                                  ? Center(
                                      child: Text(restaurantProvider.message),
                                    )
                                  : const SizedBox(),
                );
              },
            );
          },
        );
      },
    );
  }
}
