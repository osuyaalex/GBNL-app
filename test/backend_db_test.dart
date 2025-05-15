import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbnl_app/services/backend_db.dart';
import 'package:gbnl_app/services/json/market_news_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('BackendDb.getMarketNews', () {
    test('returns a list of MarketNews if the http call completes successfully', () async {
      // Mock response
      final mockResponse = jsonEncode([
        {
          "category": "general",
          "datetime": 1747239925,
          "headline": "This sector is great for investors",
          "id": 1,
          "image": "https://example.com/image.jpg",
          "related": "market",
          "source": "MarketWatch",
          "summary": "Some summary",
          "url": "https://marketwatch.com/news"
        }
      ]);

      // Create MockClient with expected response
      final client = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      final backendDb = BackendDb(client: client); // Inject client

      final result = await backendDb.getMarketNews();

      expect(result, isA<List<MarketNews>>());
      expect(result!.length, 1);
      expect(result[0].headline, contains('This sector'));
    });

    test('returns null if the http call returns an error', () async {
      final client = MockClient((request) async {
        return http.Response('Unauthorized', 401);
      });

      final backendDb = BackendDb(client: client);

      final result = await backendDb.getMarketNews();

      expect(result, isNull);
    });
  });
}
