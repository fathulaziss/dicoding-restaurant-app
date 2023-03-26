import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_customer_review_card_widget.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_detail_card_widget.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_detail_info_widget.dart';
import 'package:dicoding_restaurant_app/widgets/restaurant_detail_main_info_widget.dart';
import 'package:flutter/material.dart';

class RestaurantDetailWidget extends StatelessWidget {
  const RestaurantDetailWidget({Key? key, required this.restaurant})
      : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            '${ApiService().imageUrl}${restaurant.pictureId}',
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                RestaurantDetailMainInfoWidget(restaurant: restaurant),
                RestaurantDetailInfoWidget(
                  title: 'Description',
                  child: Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                RestaurantDetailInfoWidget(
                  title: 'Foods',
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        final food = restaurant.menus.foods[index];
                        return RestaurantDetailCardWidget(
                          item: food.name,
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
                        );
                      },
                    ),
                  ),
                ),
                RestaurantDetailInfoWidget(
                  title: 'Drinks',
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        final drink = restaurant.menus.drinks[index];
                        return RestaurantDetailCardWidget(
                          item: drink.name,
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
                        );
                      },
                    ),
                  ),
                ),
                RestaurantDetailInfoWidget(
                  title: 'Customer Review',
                  child: SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: restaurant.customerReviews.length,
                      itemBuilder: (context, index) {
                        final customerReview =
                            restaurant.customerReviews[index];
                        return RestaurantCustomerReviewCardWidget(
                          customerReview: customerReview,
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
