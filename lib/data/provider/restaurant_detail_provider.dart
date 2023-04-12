import 'dart:io';

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_detail_result_model.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail(id);
  }

  final ApiService apiService;
  final String id;
  late RestaurantDetailResultModel _restaurantDetailResult;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResultModel get restaurantDetail => _restaurantDetailResult;

  ResultState get state => _state;

  Future<dynamic> getRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      if (restaurantDetail.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
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
