import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gbnl_app/services/json/market_news_response.dart';
import 'package:http/http.dart' as http;


class BackendDb with ChangeNotifier{
  List<MarketNews>? marketNewsList;
  String? error;
  Future<List<MarketNews>?> getMarketNews() async {
    dynamic jsonResponse;
    try {
      //I wanted to keep the url and token in an env but that would have interferred with the app if you want to run the code
      String url = "https://finnhub.io/api/v1/news?category=general&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
        },
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          marketNewsList = jsonResponse.map((item) => MarketNews.fromJson(item)).toList();
          error = null;
        } else {
          marketNewsList = [];
        }

        // Notify listeners if data is available
        notifyListeners();
        return marketNewsList;
      } else if (response.statusCode == 400 ||response.statusCode == 401) {
        jsonResponse = jsonDecode(response.body);
        print('Error: $jsonResponse');
        error = 'Something went wrong. Please try again later.';
        marketNewsList = null;
        notifyListeners();
        return null;
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (error) {
      String errorMessage = error.toString();
      print('Caught error: $errorMessage');
      notifyListeners();
      return null;
    }
  }
}