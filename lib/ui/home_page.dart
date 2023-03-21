import 'package:dicoding_restaurant_app/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_widget.dart';
import 'package:flutter/material.dart';

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
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                final restaurants = parseRestaurant(snapshot.data);
                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantWidget(restaurant: restaurants[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
