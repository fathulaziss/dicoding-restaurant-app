import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantDetailMainInfoWidget extends StatelessWidget {
  const RestaurantDetailMainInfoWidget({Key? key, required this.restaurant})
      : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          restaurant.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          restaurant.categories.map((e) => e.name).join(', '),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 16),
            Text(
              restaurant.city,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 16),
            Text(
              '${restaurant.rating}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
