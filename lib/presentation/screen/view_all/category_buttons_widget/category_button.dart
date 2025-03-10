import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/presentation/bloc/news_article/news_article_bloc.dart';

class CategoryButton extends StatefulWidget {
   final TextEditingController? controller;
   final FocusNode? focusNode;
  
  CategoryButton({this.controller,this.focusNode});


  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  
  List<String> category = [
    "All",
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  int? indexOfSelcted = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        return SingleChildScrollView(
          
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Wrap(spacing: 3, children: [
                ...List.generate(category.length, (index) {
                  return ChoiceChip(
                    label: Text(category[index]),
                    selected: indexOfSelcted == index,
                    selectedColor: const Color.fromARGB(179, 241, 234, 234),
                    onSelected: (selected) {
                      widget.controller?.clear(); 
                      widget.focusNode?.unfocus();                    
                       
                      
                      
                      String categoryLabel = category[index];
                   
                     
                      if (index == 0) {
                       
                        
                        context
                            .read<NewsArticleBloc>()
                            .add(NewsArticleGetTopHeadlines());
                      } else {
                        context.read<NewsArticleBloc>().add(
                            NewsArticleCategoryWise(category: categoryLabel));
                      }
                       
                      indexOfSelcted = selected?index : index;
                      
            
                    },
                  );
                })
              ]),
            ));
      },
    );
  }
}
