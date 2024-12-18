// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArticleModel {
  String? author;
  String? id;
  String? name;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel(this.author, this.id, this.name, this.title, this.description,
      this.url, this.urlToImage, this.publishedAt, this.content);///////////////////{..................}

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }


  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      map['author'] != null ? map['author'] as String : null,
      map['id'] != null ? map['id'] as String : null,
      map['name'] != null ? map['name'] as String : null,
      map['title'] != null ? map['title'] as String : null,
      map['description'] != null ? map['description'] as String : null,
      map['url'] != null ? map['url'] as String : null,
      map['urlToImage'] != null ? map['urlToImage'] as String : null,
      map['publishedAt'] != null ? map['publishedAt'] as String : null,
      map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

      @override
  String toString() {
       return  'ArticleModel(author: $author, id: $id,name: $name,   title: $title, description: $description, url: $url,   urlToImag: $urlToImage,    publishedAt: $publishedAt,   content: $content)';
    
 
  
  }
}
