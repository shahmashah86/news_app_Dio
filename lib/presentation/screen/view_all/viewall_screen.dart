import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';
import 'package:news_app_dio/presentation/screen/view_all/category_buttons_widget/category_button.dart';
import 'package:news_app_dio/presentation/screen/widgets/content.dart';

class ViewallScreen extends StatelessWidget {
  ViewallScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

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
                        context
                            .read<NewsArticleBloc>()
                            .add(NewsArticleGetTopHeadlines());
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.chevron_left, size: 30))),
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
          Opacity(
              opacity: 0.4,
              child: Padding(
                padding: const EdgeInsets.only(left: 9, right: 9),
                child: SearchBar(
                  focusNode: focusNode,
                  onChanged: (value) {
                    if (searchController.text.trim().isNotEmpty) {
                      context.read<NewsArticleBloc>().add(NewsArticleSearchNews(
                            searchtext: searchController.text.trim(),
                          ));
                    }
                  },
                  controller: searchController,
                  padding:
                      const WidgetStatePropertyAll(EdgeInsets.only(left: 10)),
                  shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
                  hintText: "Search",
                  leading: const Icon(Icons.search),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(179, 241, 234, 234),
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          CategoryButton(
            controller: searchController,
            focusNode: focusNode,
          ),
          const SizedBox(
            height: 6,
          ),
          // const Expanded(child: Center(child:  ScrollNews())),
          Expanded(
            child: BlocBuilder<NewsArticleBloc, NewsArticleState>(
              builder: (context, state) {
                // log(state.toString(), name: "article state");
                if (state is NewsArticleLoading) {
                  log("loading");
                  return const Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          // color: Colors.yellow,

                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  );
                }
                if (state is NewsArticleLoaded &&
                    state.newsArticleList.isNotEmpty) {
                  log('loaded');
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 2),
                      child: Column(
                        children: [
                          ...List.generate(state.newsArticleList.length,
                              (index) {
                            final news = state.newsArticleList[index];

                            return Content(
                              newsContent: news,
                            );
                          })
                        ],
                      ),
                    ),
                  );
                }

                if (state is NewsArticleLoaded &&
                    state.newsArticleList.isEmpty) {
                  log('searchnews');
                  if (state.isError == true) {
                    return SnackBar(
                      content: const Text("Something went wrong"),
                      action: SnackBarAction(
                        label: "undo",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        disabledTextColor: Colors.black12.withOpacity(0.3),
                      ),
                    );
                  }
                  if (state.searchNewsResult.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 2),
                        child: Column(
                          children: [
                            ...List.generate(state.searchNewsResult.length,
                                (index) {
                              final news = state.searchNewsResult[index];

                              return Content(
                                newsContent: news,
                              );
                            })
                          ],
                        ),
                      ),
                    );
                  }
                  if (state.isLoading == true) {
                    return Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()));
                  }
                  // state.isLoading==true?CircularProgressIndicator():state.isLoading==false?Text(''''''):Text('ll');

                  // Future.delayed(Duration(seconds: 4));

//  return CircularProgressIndicator();

                  return const Center(
                      child: Text(
                    "search result unavailable",
                    style: TextStyle(fontSize: 15),
                  ));
                }
                if (state is newsArticleError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.90,
                        height: 50,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_rounded,
                              color: Color.fromARGB(255, 255, 110, 99),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Poor network conntection")
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text("loading..."));
              },
            ),
          )
        ]));
  }
}
