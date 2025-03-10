// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news_app_dio/model/article_model.dart';
import 'package:news_app_dio/presentation/screen/news_description/news_description_screen.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.newsContent,
  }) : super(key: key);

  final ArticleModel newsContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewsDescriptionScreen(news: newsContent);
          }));
        },
        child: Container(
          width: double.infinity,
          color: const Color.fromARGB(179, 241, 234, 234),
          child: Row(children: [
            Container(
              height: 160,
              width: 120,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade100,
                    Colors.black45,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                // image: const DecorationImage(
                //     image: AssetImage(
                //         "assets/images/image2.jpg"),
                //     fit: BoxFit.cover),

                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: newsContent.urlToImage != null
                    ? newsContent.urlToImage!
                    : "",
                placeholder: (context, url) => const Center(child: SpinKitThreeBounce(size: 20,color: const Color.fromARGB(255, 220, 215, 215),)),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/imagenotFound.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.yellow

                color: Color.fromARGB(179, 241, 234, 234),

                height: 160,
                width: double.infinity,
                // width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        ("news"),
                        style: TextStyle(
                          color: Color.fromARGB(255, 141, 110, 99),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Text(
                          newsContent.title ?? 'title',
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 4,
                                  backgroundColor:
                                      Color.fromARGB(255, 153, 180, 193),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    newsContent.author ?? "author",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            newsContent.publishedAt ?? "Date",
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
