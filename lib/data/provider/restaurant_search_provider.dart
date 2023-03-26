import 'dart:io';

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_search_result_model.dart';
import 'package:flutter/foundation.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  RestaurantSearchProvider({required this.apiService});

  final ApiService apiService;
  late RestaurantSearchResultModel _restaurantSearchResult;

  ResultState _state = ResultState.noData;
  String _message = '';

  String get message => _message;

  RestaurantSearchResultModel get result => _restaurantSearchResult;

  ResultState get state => _state;

  Future<dynamic> getRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurantSearch;
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
