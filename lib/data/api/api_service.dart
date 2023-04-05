import 'dart:convert';

import 'package:dicoding_restaurant_app/data/models/restaurant_detail_result_model.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_result_model.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_search_result_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _imageUrl = '${_baseUrl}images/large/';

  String get imageUrl => _imageUrl;

  Future<RestaurantResultModel> getRestaurant() async {
    final response = await http.get(Uri.parse('${_baseUrl}list'));

    if (response.statusCode == 200) {
      return RestaurantResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResultModel> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResultModel> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearchResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}
