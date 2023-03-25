import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant,
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: _buildRestaurantPicture(),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
              Text(
                restaurant.city,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 16),
              Text(
                '${restaurant.rating}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantPicture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        '${ApiService().imageUrl}${restaurant.pictureId}',
        width: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
