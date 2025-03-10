import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';
import 'package:news_app_dio/presentation/screen/home/widget/carouselnews.dart';

import 'package:news_app_dio/presentation/screen/view_all/viewall_screen.dart';
import 'package:news_app_dio/presentation/screen/widgets/scroll_news.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override

  @override
  void initState() {
    context.read<NewsArticleBloc>().add(NewsArticleGetTopHeadlines());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 3, right: 3, top: 4),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(179, 224, 217, 217),
                ),
                height: 67,
                width: double.infinity,
                child: const Center(
                    child: Text(
                  "🌍 World  News  are in Focus",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ))),
          ),
          const SizedBox(
            height: 10,
          ),
          Carouselnews(),
         const SizedBox(height: 10,),
           
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Row(
              children: [
                const Text(
                  "Recomendation",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ViewallScreen(),
                      )),
                  child: const Text(
                    "View all",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          const Expanded(child: ScrollNews())
        ]),
      ),
    );
  }
}