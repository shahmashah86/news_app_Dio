import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:news_app_dio/model/article_model.dart';
import 'package:news_app_dio/package/api_service.dart';

String apiKey = "8efa17edfdf1485d874f5a399fc1644e";


class GetRepository {
  Future<List<ArticleModel>> getTopHeadlines({String? searchitem}) async {
    try {
      final Response response = await ApiService.get(
          path: "top-headlines",
          queryParameters: {'country': 'us', 'apiKey': apiKey,});
      if (response.statusCode == 200) {
        // log(response.data['articles'].toString(),name:"artile list");
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


  Future<List<ArticleModel>> getSearcResult({String? searchitem,String? category}) async{
    try{
      log('categorysearch!');
    
      final Response response=await ApiService.get(path:"top-headlines",queryParameters: {'q':searchitem,'category': category,'apikey':apiKey});
      // log(response.data['articles'].toString(),name: "search Response");
      if(response.statusCode==200){
        return (response.data['articles'] as List<dynamic>).map((toElement)=>ArticleModel.fromMap(toElement)).toList();
        
      }
      else{
               throw "Something went wrong in response=getSearchResilt";
      }
    }
    catch(e){
      throw "Something went wrong in code";
    }
    



  }
}
