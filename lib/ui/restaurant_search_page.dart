import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_search_provider.dart';
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
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (context) => RestaurantSearchProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Restaurant Search')),
        body: Column(
          children: [
            Consumer<RestaurantSearchProvider>(
              builder: (context, state, child) {
                return CustomSearchWidget(
                  controller: controllerSearch,
                  onSubmitted: (value) {
                    state.getRestaurantSearch(value);
                  },
                );
              },
            ),
            Expanded(child: _buildRestaurantList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
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
