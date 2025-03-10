part of 'news_article_bloc.dart';


sealed class NewsArticleEvent {}

class NewsArticleGetTopHeadlines extends NewsArticleEvent{

}

class NewsArticleCategoryWise extends NewsArticleEvent{
  final String category;
  // final int index;

  NewsArticleCategoryWise( {required this.category});
}

class  NewsArticleSearchNews extends NewsArticleEvent{
  final String? searchtext;
    NewsArticleSearchNews({this.searchtext});
  
}

