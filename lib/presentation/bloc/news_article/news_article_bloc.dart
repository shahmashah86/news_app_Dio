import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/model/article_model.dart';
import 'package:news_app_dio/repository/get_repository.dart';

part 'news_article_event.dart';
part 'news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState> {
  NewsArticleBloc() : super(NewsArticleInitial()) {
    on<NewsArticleGetTopHeadlines>(_getTopHeadlines);
    on<NewsArticleCategoryWise>(_getCategorywiseNews);
    on<SearchNews>(_searchNews);
    
      }

  Future<void> _getTopHeadlines(NewsArticleGetTopHeadlines event, Emitter<NewsArticleState> emit) async {
    emit(NewsArticleLoading());
    try{
      List<ArticleModel> newsList=await GetRepository().getTopeadlines();
      emit(NewsArticleLoaded(newsArticleList: newsList));
    }
    catch(e){
      emit(newsArticleError());
    }
  }

  Future<void> _getCategorywiseNews(NewsArticleCategoryWise event, Emitter<NewsArticleState> emit) async{
    final currentstate=state;
    // emit(NewsArticleLoading());
    if(currentstate is NewsArticleLoaded){
    try{
         List<ArticleModel> newsList=await GetRepository().getCategoryWiseHeadlines(category: event.category);
      emit(currentstate.copywith(newsArticleList: newsList));
    }
  
  catch(e){
      emit(newsArticleError());
    }
}
}

  FutureOr<void> _searchNews(SearchNews event, Emitter<NewsArticleState> emit) async{

     final currentstate=state;
    // emit(NewsArticleLoading());
    if(currentstate is NewsArticleLoaded){
    try{
         List<ArticleModel> newsList =await GetRepository().getTopeadlines(searchitem: event.searchtext);
      emit(currentstate.copywith(searchNewsResult: newsList));
    }
  
  catch(e){
      emit(newsArticleError());
    }
  }
  }
}