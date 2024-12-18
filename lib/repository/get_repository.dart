import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app_dio/model/article_model.dart';
import 'package:news_app_dio/package/api_service.dart';

String apiKey = "f581470f7313431cb4646404d0feb37a";


class GetRepository {
  Future<List<ArticleModel>> getTopeadlines({String? searchitem}) async {
    try {
      final Response response = await ApiService.get(
          path: "top-headlines",
          queryParameters: {'country': 'us', 'apiKey': apiKey,'q':'searchitem'});
      if (response.statusCode == 200) {
        log("data is present");
        return (response.data['articles'] as List)
            .map((eachElement) => ArticleModel.fromMap(eachElement))
            .toList();
      } else {
        throw "Something went wrong in response=getAllTopHeadlines";
      }
    } catch (e) {
      throw "Something wrong woth the reques/code-getAlltopHeadlines";
    }
  }

  Future<List<ArticleModel>> getCategoryWiseHeadlines({required String category}) async {
    try {
      final Response response = await ApiService.get(
          path: "top-headlines",
          queryParameters: {'category': category, 'apiKey': apiKey});
      if (response.statusCode == 200) {
        
        return (response.data['articles'] as List<dynamic>)
            .map((eachElement) => ArticleModel.fromMap(eachElement))
            .toList();
      } else {
        throw "Something went wrong in response=getCategoryWiseTopHeadlines";
      }
    } catch (e) {
      throw "Something went wrong in request/code=getcategorywiseTopHeadlines";
    }
  }
}
