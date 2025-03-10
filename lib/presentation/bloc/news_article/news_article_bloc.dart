import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/model/article_model.dart';
import 'package:news_app_dio/repository/get_repository.dart';

part 'news_article_event.dart';
part 'news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState> {
  NewsArticleBloc() : super(NewsArticleInitial()) {
    on<NewsArticleGetTopHeadlines>(_getTopHeadlines);
    on<NewsArticleCategoryWise>(_getCategorywiseNews);
    on<NewsArticleSearchNews>(_searchNews);
  }

  Future<void> _getTopHeadlines(
      NewsArticleGetTopHeadlines event, Emitter<NewsArticleState> emit) async {
    emit(NewsArticleLoading());
    try {
      log('_getTopHeadlines');
      List<ArticleModel> newsList = await GetRepository().getTopHeadlines();
      emit(NewsArticleLoaded(
        newsArticleList: newsList,
      ));
    } catch (e) {
      log(e.toString());
      emit(newsArticleError());
    }
  }

  Future<void> _getCategorywiseNews(
      NewsArticleCategoryWise event, Emitter<NewsArticleState> emit) async {
    final currentstate = state;

    if (currentstate is NewsArticleLoaded) {
      log('inside current getcategory wise');
      final newState= currentstate.copywith(
          isLoading: true, currentCategory: event.category);
      emit(newState);
      try {
        log('categorywise');
        //  String category= currentstate.currentCategory;
        //   log(category);
        List<ArticleModel> newsList = await GetRepository()
            .getCategoryWiseHeadlines(category: event.category);
        emit(currentstate.copywith(
            newsArticleList: newsList,
            isLoading: false,
            currentCategory: event.category));
      } catch (e) {
        log(e.toString());

        emit(currentstate.copywith(
          newsArticleList: currentstate.newsArticleList,
          currentCategory: event.category,
          isLoading: false,
          isError: true,
          message: e.toString(),
        ));
      }
    }
  }

  FutureOr<void> _searchNews(
      NewsArticleSearchNews event, Emitter<NewsArticleState> emit) async {
    final currentstate = state;
    // emit(NewsArticleLoading());
    if (currentstate is NewsArticleLoaded) {
      emit(currentstate.copywith(
          newsArticleList: currentstate.newsArticleList, isLoading: true));
      try {
        if (event.searchtext == null) {
          log('null search');
          emit(currentstate.copywith(
            newsArticleList: currentstate.newsArticleList,
          ));
        } else {
          String category = currentstate.currentCategory;
          log(category, name: "search category");

          List<ArticleModel> newsList = await GetRepository().getSearcResult(
              searchitem: event.searchtext,
              category: currentstate.currentCategory);
          if (newsList.isEmpty) {
            emit(currentstate.copywith(
                searchNewsResult: [], newsArticleList: [], isLoading: true));
            log('inside circular');
            Future.delayed(Duration(seconds: 7));

            emit(currentstate.copywith(
                searchNewsResult: [], newsArticleList: [], isLoading: false));
          } else {
            emit(currentstate
                .copywith(searchNewsResult: newsList, newsArticleList: []));
          }
          // emit(currentstate.copywith(searchNewsResult: newsList,newsArticleList: []));
        }
      } catch (e) {
        log('error');
        emit(currentstate.copywith(
            newsArticleList: currentstate.newsArticleList,
            isError: true,
            message: e.toString(),
            isLoading: false));
      }
    }
  }
}
