import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';

class Carouselnews extends StatelessWidget {
  Carouselnews({super.key});
  final ValueNotifier<int> _current = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        if (state is NewsArticleLoaded && state.currentCategory.isEmpty
        ) {

          log('inside carousel');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: state.newsArticleList.length>=4?4:4,
                itemBuilder: (context, index, itemindex) {
                final news = state.newsArticleList[index];

                  return Stack(children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.black45,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: 250,
                        imageUrl: news.urlToImage ?? "",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/imagenotFound.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Chip(
                            label: Text(
                              'Top News',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            news.title ?? "Unavialabale",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'CNN Indonesia • 6 hours ago',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    //   setState(() {
                    _current.value = index;
                    // _current.ad

                    //   });
                  },
                  enlargeCenterPage: true,
                  autoPlay: true,
                  height: 250.0,
                  enlargeFactor: 0.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 170, right: 160),
                child: SizedBox(
                  height: 20,
                  child: ValueListenableBuilder(
                      valueListenable: _current,
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Row(children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: value == index
                                        ? Colors.blue.shade300
                                        : Colors.brown.shade300),
                                height: 7,
                                width: value == index ? 20 : 10,
                              ),
                              SizedBox(
                                width: 5,
                              )
                            ]);
                          },
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                        );
                      }),
                ),
              )
            ],
          );
        }
        return CarouselSlider(
            items: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                    Colors.grey.shade300
                  ], stops: [
                    0.1,
                    0.4,
                    0.9
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )
            ],
            options: CarouselOptions(
                enlargeCenterPage: true,
                // autoPlay: true,
                height: 250.0,
                enlargeFactor: 0.2));
      },
    );
  }
}
