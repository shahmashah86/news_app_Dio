import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';
import 'package:news_app_dio/presentation/screen/view_all/category_buttons_widget/category_button.dart';

import 'package:news_app_dio/presentation/screen/widgets/scroll_news.dart';

class ViewallScreen extends StatelessWidget {
  const ViewallScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 13,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(direction: Axis.vertical, children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey.shade300),
                  child: IconButton(
                      onPressed: () {
                        context.read<NewsArticleBloc>().add(NewsArticleGetTopHeadlines());
                        Navigator.pop(context);
                        
                      },
                      icon: Icon(Icons.chevron_left, size: 30))),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Discover",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              const Text("News from all over the world",
                  style: TextStyle(color: Colors.black54)),
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          const Opacity(
              opacity: 0.4,
              child: Padding(
                padding: EdgeInsets.only(left: 9, right: 9),
                child: SearchBar(
                  padding: WidgetStatePropertyAll(EdgeInsets.only(left: 10)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
                  hintText: "Search",
                  leading: Icon(Icons.search),
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(179, 241, 234, 234),
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          const CategoryButton(),
          SizedBox(height: 6,),
          Expanded(child: Center(child: const ScrollNews())),
        ]));
  }
}
