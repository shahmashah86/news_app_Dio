
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';

import 'package:news_app_dio/presentation/screen/widgets/content.dart';

class ScrollNews extends StatelessWidget {
  const ScrollNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        // log(state.toString(), name: "article state");
        if (state is NewsArticleLoading) {
          return const  Column(
            children: [
            SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  // color: Colors.yellow,

                  child:SpinKitChasingDots(color:Colors.grey)
                ),
              ),
            ],
          );
        }

        if (state is NewsArticleLoaded && state.currentCategory.isEmpty) {
          log("newsarticleloaded");
          if (state.isError == true) {
            return SnackBar(
              content: Text("Something went wrong"),
              action: SnackBarAction(
                label: "undo",
                onPressed: () {
                  Navigator.pop(context);
                },
                disabledTextColor: Colors.black12.withOpacity(0.3),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Column(
                children: [
                  ...List.generate(
                 
                           state.newsArticleList.length, (index) {
                    final news =  state.newsArticleList[index];


                    return Content(newsContent: news,);
                    
                  })
                ],
              ),
            ),
          );
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
                    Text("error")
                  ],
                ),
              ),
            ],
          );
        }
        return Text("loading...");
      },
    );
  }
}
