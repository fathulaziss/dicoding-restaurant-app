import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/models/restaurant_result_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurant', () {
    final client = MockClient();
    final apiService = ApiService();

    test('returns an Restaurant if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('${apiService.baseUrl}list'))).thenAnswer(
        (_) async => http.Response(
          '{"error": false, "message": "success", "count": 20, "restaurants": []}',
          200,
        ),
      );

      expect(
        await apiService.getRestaurant(client: client),
        isA<RestaurantResultModel>(),
      );
    });

    test('throws an exception if the http call completes with an error', () {
      when(
        client.get(Uri.parse('${apiService.baseUrl}list')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(apiService.getRestaurant(client: client), throwsException);
    });
  });
}
