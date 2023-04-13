// ignore_for_file: cascade_invocations

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/provider/restaurant_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test parsing data restaurant', () async {
    // arrange
    final restaurantProvider = RestaurantProvider(apiService: ApiService());
    // act
    await restaurantProvider.getRestaurant();
    // assert
    final result = restaurantProvider.restaurant.error == false;
    expect(result, true);
  });
}
