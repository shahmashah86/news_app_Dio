part of 'news_article_bloc.dart';


sealed class NewsArticleEvent {}

class NewsArticleGetTopHeadlines extends NewsArticleEvent{

}

class NewsArticleCategoryWise extends NewsArticleEvent{
  final String category;
  // final int index;

  NewsArticleCategoryWise( {required this.category});
}

abstract class  SearchNews extends NewsArticleEvent{
  final String searchtext;
    SearchNews({required this.searchtext});
  
}

