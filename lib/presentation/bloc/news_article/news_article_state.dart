part of 'news_article_bloc.dart';

sealed class NewsArticleState {}

final class NewsArticleInitial extends NewsArticleState {}

final class NewsArticleLoading extends NewsArticleState {}

final class NewsArticleLoaded extends NewsArticleState {
  late List<ArticleModel> newsArticleList;
  final List<ArticleModel> searchNewsResult;
  final String currentCategory;
  final bool isLoading;
  final bool isError;
  final String message;

  NewsArticleLoaded({
   this.isLoading =false,
   this.isError =false,
    this.message ="",
    this.currentCategory="",
    this.searchNewsResult = const [],
    required this.newsArticleList,
  });
  NewsArticleLoaded copywith(
      {List<ArticleModel>? newsArticleList,
      List<ArticleModel>? searchNewsResult,
      String? currentCategory,
      String? message,
      bool? isError,
      bool? isLoading
      }) {
    return NewsArticleLoaded(
        searchNewsResult: searchNewsResult ?? this.searchNewsResult,
        newsArticleList: newsArticleList ?? this.newsArticleList,
        currentCategory: currentCategory?? this.currentCategory,
        message: message??this.message,
        isError: isError??this.isError,
        isLoading: isLoading??this.isLoading



        );
  
  }
}

final class newsArticleError extends NewsArticleState {}
