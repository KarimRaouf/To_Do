class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;

  PostModel({
    this.uId,
    this.name,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uId': uId,
      'postImage': postImage,
      'image': image,
    };
  }
}
