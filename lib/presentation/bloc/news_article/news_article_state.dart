part of 'news_article_bloc.dart';

sealed class NewsArticleState {}

final class NewsArticleInitial extends NewsArticleState {}

final class NewsArticleLoading extends NewsArticleState {}

final class NewsArticleLoaded extends NewsArticleState {
  late List<ArticleModel> newsArticleList;
  final List<ArticleModel> searchNewsResult;

  NewsArticleLoaded({this.searchNewsResult=const[], required this.newsArticleList});
  NewsArticleLoaded copywith({List<ArticleModel>? newsArticleList, List<ArticleModel>? searchNewsResult}) {
    return NewsArticleLoaded(searchNewsResult:searchNewsResult?? this.searchNewsResult,
        newsArticleList: newsArticleList ?? this.newsArticleList);
  }
}

final class newsArticleError extends NewsArticleState {}
