import 'package:flutter/material.dart';
import 'package:flutter_app_dio_api/addPostPage.dart';
import 'package:flutter_app_dio_api/api/fetchData.dart';
import 'package:flutter_app_dio_api/api/postModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchData _fetchData = FetchData();
@override
  void initState() {
  _fetchData.fetchPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _fetchData.fetchPosts(),
          // ignore: missing_return
          builder: (context,snapchot){

            List<PostModel> data = snapchot.data;

            if(data != null){

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return Row(
                      children: [
                        Image.network("http://192.168.1.2:1337"+ data[index].imageUrl,width: 100,height: 100,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    );
                  });
            }


          },
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          print("Add Post Page Clicked");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostPage()));

        },
        child: Container(
          width: 100,
            height: 100,
            color:Colors.pink,child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add,color: Colors.white,size: 40,),
                Text("Add",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))
              ],
            ),

        ),
      ),
    );

  }
}
