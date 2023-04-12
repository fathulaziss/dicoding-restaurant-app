import 'package:dicoding_restaurant_app/data/database/database_helper.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_model.dart';
import 'package:dicoding_restaurant_app/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider extends ChangeNotifier {
  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  final DatabaseHelper databaseHelper;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantModel> _favorites = [];
  List<RestaurantModel> get favorites => _favorites;

  Future<void> _getFavorites() async {
    _state = ResultState.loading;
    notifyListeners();
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> addFavorite(RestaurantModel restaurant) async {
    try {
      await databaseHelper.insertFavorites(restaurant);
      await _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorites(id);
      await _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final restaurantFavorite = await databaseHelper.getFavoriteById(id);
    return restaurantFavorite.isNotEmpty;
  }
}
