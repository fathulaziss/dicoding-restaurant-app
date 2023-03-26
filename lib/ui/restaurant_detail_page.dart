import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_detail_widget.dart';
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
              return RestaurantDetailWidget(
                restaurant: state.result.restaurant!,
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
      ),
    );
  }
}
