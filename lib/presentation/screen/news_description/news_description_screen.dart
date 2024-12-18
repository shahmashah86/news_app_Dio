import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_dio/model/article_model.dart';

class NewsDescriptionScreen extends StatelessWidget {
  final  ArticleModel  news;
  const NewsDescriptionScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(imageUrl: 
            news.urlToImage??"",
            height: 330,
            width: double.infinity,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
                                                            "assets/images/imagenotFound.png",
                                                            fit: BoxFit.cover,
                                                          ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Sports',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Trending • 6 hours ago',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                           Text(news.title??"",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),



                          const SizedBox(height: 20),
                          // Article body
                           Text(news.description??"",

                            style:const  TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),

                              const SizedBox(height: 20),
                          // Article body
                           Text(news.content??"",

                            style:const  TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 40,
              left: 6,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.chevron_left, color: Colors.white)),
              )),
          const Positioned(
            top: 40,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: Icon(Icons.bookmark_border, color: Colors.white),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: Icon(Icons.share, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
