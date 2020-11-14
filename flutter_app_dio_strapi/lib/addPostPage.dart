import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_dio_api/api/fetchData.dart';
import 'package:flutter_app_dio_api/homePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController _titleEditController = TextEditingController();
  FetchData _fetchData = FetchData();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _fetchData = FetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post Now"),),
      body: Column(
        children: [
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Column(
                  children: [
                    Image.file(_image,width: 200,height: 200,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller:_titleEditController ,
                      ),
                    ),
                    FlatButton(onPressed: () async {



                      String url = "http://192.168.1.2:1337/posts";

                      Response response;
                      Dio dio = new Dio();
                      response = await dio.post(url,data: await _fetchData.addPostData(_image, _titleEditController.text));

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    }, child: Text("Add Post")),
                  ],
                ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }



  Future<FormData> addPostData(File image,String title) async {
    var formData = FormData();
    formData.fields.add(MapEntry("data", '{"title":"$title"}'));

    if (image != null) {
      formData.files.add(MapEntry(
        "files.image",
        await MultipartFile.fromFile(image.path,
            filename: "post.png"),
      ));
    }

    return formData;
  }





}
