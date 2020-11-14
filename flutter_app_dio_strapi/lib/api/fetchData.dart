import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_app_dio_api/api/postModel.dart';

class FetchData {

  Future <List <PostModel> > fetchPosts () async {
    String url = "http://192.168.1.2:1337/posts";

    Response response;
    Dio dio = new Dio();
    response = await dio.get(url);

    if(response.statusCode == 200 ){
      var body = response.data;

      List <PostModel> posts = [];

      for(var item in body) {
        posts.add(PostModel.fromJson(item));
      }
      return posts;
    }
    return null;


  }

  Future<FormData> addPostData(File image,String title) async {
    var formData = FormData();
    formData.fields.add(MapEntry("data", '{"title":"$title"}'));

    String fileName = image.path.split('/').last;

    if (image != null) {
      formData.files.add(MapEntry(
        "files.image",
        await MultipartFile.fromFile(image.path,
            contentType: MediaType('image', fileName.split('.').last),
            filename: fileName),
      ));
    }

    return formData;
  }

}