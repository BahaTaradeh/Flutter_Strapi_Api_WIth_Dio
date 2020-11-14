class PostModel{
  int id;
  String title,imageUrl;

  PostModel(this.id, this.title, this.imageUrl);

  PostModel.fromJson(Map<String,dynamic>map){
    this.id = map['id'];
    this.title = map['title'];
    this.imageUrl = map['image']['url'];



  }
}