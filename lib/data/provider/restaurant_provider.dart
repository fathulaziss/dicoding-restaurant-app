import 'dart:io';

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_result_model.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantProvider({required this.apiService}) {
    _getRestaurant();
  }

  final ApiService apiService;
  late RestaurantResultModel _restaurantResult;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResultModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _getRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } on SocketException catch (e) {
      _state = ResultState.error;
      if (e.toString().contains('Failed host lookup')) {
        _message = 'Error --> No Internet Connection';
      } else {
        _message = 'Error --> $e';
      }
      notifyListeners();
      return _message;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
