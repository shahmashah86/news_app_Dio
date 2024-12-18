

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';
import 'package:news_app_dio/presentation/screen/news_description/news_description_screen.dart';


class ScrollNews extends StatelessWidget {
 
  const ScrollNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        if (state is NewsArticleLoading) {
            return const Column(
              children: [SizedBox(height: 50,),
                Center(
                  child: SizedBox(
                      height:50,
                      width: 50,
                      // color: Colors.yellow,
                      
                      child: CircularProgressIndicator(),
                    ),
                ),
              ],
            );
    
        }
        if (state is NewsArticleLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Column(
                children: [
                  ...List.generate(state.newsArticleList.length, (index) {
                    final news = state.newsArticleList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          // List<ArticleModel> articleList =
                          //     await GetRepository()
                          //         .getCategoryWiseHeadlines(category: 'Sports');
                          // log(articleList.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NewsDescriptionScreen(news:news);
                          }));
                        },
                        child:
                         Container(
                          width: double.infinity,
                          color: const Color.fromARGB(
                                      179, 241, 234, 234),
                          child: Row(children: [
                            
                            Container(height: 160,width: 120,clipBehavior: Clip.antiAlias,
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
                        
                              child: CachedNetworkImage(imageUrl: news.urlToImage !=null? news.urlToImage!:"",
                            placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                                            "assets/images/imagenotFound.png",
                                                            fit: BoxFit.cover,
                                                          ),
                          fit: BoxFit.cover,),
                            ),
                            Expanded(
                              child: Container(
                              
                                  // color: Colors.yellow
                                              
                                  color:  Color.fromARGB(
                                      179, 241, 234, 234),
                                
                                height: 160,
                                width: double.infinity,
                                // width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        ("news"),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 141, 110, 99),
                                        ),
                                      ),
                                    const  SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          news.title ?? 'title',
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Row(
                                              children: [
                                               const CircleAvatar(
                                                  radius: 4,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 153, 180, 193),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    news.author ?? "author",
                                                  maxLines: 1,
                                                  style: const TextStyle(overflow:TextOverflow.ellipsis),),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            news.publishedAt ?? "Date",
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
                  })
                ],
              ),
            ),
          );
        }
        return Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 30,),
            Container(
              width:MediaQuery.sizeOf(context).width*0.90,height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.error_rounded,color: const Color.fromARGB(255, 255, 110, 99),),SizedBox(width: 5,),Text("Poor network conntection")],),),
          ],
        );
      },
    );
  }
}
