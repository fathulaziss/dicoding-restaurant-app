import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant App')),
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
          ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(apiService: ApiService()),
            child: Expanded(child: _buildRestaurantList(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              final restaurants = state.result.restaurants[index];
              return RestaurantWidget(restaurant: restaurants);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
